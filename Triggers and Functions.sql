-- Advanced PL/PGSQL 
/* A trigger that updates the Products table after an order is placed.
Every time a new Order_Item is inserted, the stock of the corresponding product is reduced.
*/

CREATE OR REPLACE FUNCTION decrease_stock()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Products
    SET stock = stock - NEW.quantity
    WHERE id = NEW.product_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_stock
AFTER INSERT ON Order_Items
FOR EACH ROW EXECUTE FUNCTION decrease_stock();

/* Block orders if there’s not enough stock.
Before adding an order item, it checks the stock.
If stock is too low, it blocks the order with an error message.*/

CREATE OR REPLACE FUNCTION check_stock_before_order()
RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT stock FROM Products WHERE id = NEW.product_id) < NEW.quantity THEN
        RAISE EXCEPTION 'Not enough stock available for this product';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_out_of_stock
BEFORE INSERT ON Order_Items
FOR EACH ROW EXECUTE FUNCTION check_stock_before_order();



-- Mark Products as "Out of Stock" Automatically
UPDATE Products SET stock = 0 WHERE stock < 0;


-- Let us Test Stock Management
-- Check Initial Stock
SELECT id, name, stock FROM Products WHERE id = 1;

-- Add Order Items 
INSERT INTO Orders (user_id, total_price, status) 
VALUES (1, 1999.99, 'pending') RETURNING id;

-- Adds 2 Units 
INSERT INTO Order_Items (order_id, product_id, quantity, price)
VALUES (1, 1, 2, 1999.99);

-- Check Stock Again if the stock decreased:
SELECT id, name, stock FROM Products WHERE id = 1;



-- This function will fetch product details like name, description, price, stock, and review
CREATE OR REPLACE FUNCTION get_product_details(product_id INT)
RETURNS TABLE (
    product_name TEXT,
    description TEXT,
    price NUMERIC,
    stock INT,
    category TEXT,
    avg_rating NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.name AS product_name,
        p.description,
        p.price,
        p.stock,
        c.category_name AS category,
        (SELECT COALESCE(AVG(r.rating), 0) FROM reviews r WHERE r.product_id = p.product_id) AS avg_rating
    FROM products p
    JOIN categories c ON p.category_id = c.category_id
    WHERE p.product_id = get_product_details.product_id;
END;
$$ LANGUAGE plpgsql;

select * from order_items;
select * from products;
select * from cart;

/*Stored Procedure for Order Processing
We'll create a stored procedure to:

Move items from the cart to orders when checkout happens.

Deduct stock from products.

Generate an order ID.*/

CREATE OR REPLACE FUNCTION process_order(user_id INT) 
RETURNS INT AS $$
DECLARE
    order_id INT;
BEGIN
    -- Create a new order
    INSERT INTO orders (user_id, created_at, status)
    VALUES (user_id, NOW(), 'pending')
    RETURNING id INTO order_id;

    -- Move cart items to order_items and update stock
    INSERT INTO order_items (order_id, product_id, quantity, price)
    SELECT order_id, c.product_id, c.quantity, p.price
    FROM cart c
    JOIN products p ON c.product_id = p.id
    WHERE c.user_id = user_id;

    -- Deduct stock
    UPDATE products
    SET stock = stock - c.quantity
    FROM cart c
    WHERE products.id = c.product_id AND c.user_id = user_id;

    -- Clear cart after order is placed
    DELETE FROM cart WHERE user_id = user_id;

    RETURN order_id;
END;
$$ LANGUAGE plpgsql;

/*Function to Get Cart Summary
This will fetch all cart items for a user, including subtotal calculations.*/ 
CREATE OR REPLACE FUNCTION get_cart_summary(user_id INT)
RETURNS TABLE(product_name TEXT, price NUMERIC, quantity INT, total_price NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT p.name, p.price, c.quantity, (p.price * c.quantity) AS total_price
    FROM cart c
    JOIN products p ON c.product_id = p.id
    WHERE c.user_id = user_id;
END;
$$ LANGUAGE plpgsql;

--------------------------
