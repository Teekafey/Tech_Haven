# TechHaven

## TechHaven: Mini E-Commerce Web App for Tech Gadgets

TechHaven is a e-commerce platform built to showcase a database-centered architecture where every user action interacts directly with the underlying database. This project highlights my skills as a Database Developer by integrating PostgreSQL with a Flask backend and a minimal HTML/CSS/JavaScript frontend.

![image](https://github.com/user-attachments/assets/cad4272f-26fc-4e94-8b09-189cc9901253)


💭**Thought** : **I wanted to build a project that truly shows what a great database looks like in action. This is it.**

---

## 🚀 Live Features
- **Homepage** dynamically loads all products from PostgreSQL.
- **Product View Page** displays all product details fetched from the database.
- **Cart Page** allows real-time cart management (Add, Remove, Update Quantity).
- **Order Summary Page** displays user shipping information and order details.

---

## 💡 Tech Stack
- **Database:** PostgreSQL (with advanced SQL logic)
- **Frontend:** HTML, CSS, JavaScript (Fetch API)
- **Backend:** Python Flask (REST API)

---

## 🧠 Key Features
### 🗄️ Database Design (PostgreSQL)
![ERD Diagram](https://github.com/user-attachments/assets/9a5a06c4-f46f-4fb3-be65-13b33a2764c2)
Find [SQL codes here](https://github.com/Teekafey/Tech_Haven/blob/main/Tables%20and%20Relationships.sql)

---------
- **Relational schema with tables like:** 
  - `products`, `users`, `cart`, `orders`, `order_items`, `reviews`, `suppliers`, `payments`, `categories`
- **Advanced SQL Logic:**
  - Triggers to prevent out-of-stock orders
  - Stored Procedures to process orders
  - Functions for cart totals

### 🧩 API Endpoints (Flask)
- `GET /api/products` – Fetch all products
- `GET /api/products/<id>` – Fetch product details
- `GET /api/cart?user_id=1` – Get cart for a user
- `GET /api/order-summary?user_id=1` – Get latest order summary

Find [python api codes here](https://github.com/Teekafey/Tech_Haven/blob/main/Python_api.py)

### 🖥️ Frontend (JS)
- Dynamic loading of products and order info
- Interactive cart UI (plus/minus buttons, remove, totals)
- Checkout and summary flow

---
# 🚀 Fetching Products with API from Database 
## Starting, Setup & Run Locally

- Open PostgreSQL, start up my Database.
- Open cmd or gitbash
    - ```python
      # Backend
      cd backend
      python -m venv venv
      venv\Scripts\activate
      python app.py
      ```
      ![cmd ](https://github.com/user-attachments/assets/4350c583-e77d-4432-a40f-bf53a7af2e3a)

- Open VScode and Go live.

  
🏠 **Products on Homepage**

![products](https://github.com/user-attachments/assets/847dd404-518c-4139-a830-e9983f7d7d3e)

🎆**Products on API**

![api_products](https://github.com/user-attachments/assets/fa384615-d618-4867-b24a-7c51476fbd24)

🛒 **Products on Cart**

![carts](https://github.com/user-attachments/assets/37f6d9c5-3803-4821-8753-5fc5d4c80bc7)

🎆**Products on API**

![api_cart](https://github.com/user-attachments/assets/af871d10-37be-498f-9e65-9a865476cf9a)

💱 **Order Summary** 

![order_summary](https://github.com/user-attachments/assets/3320234f-8afe-4b42-8cd7-f8e2fbc4764f)

# Advanced PG/PLSQL process
Find all [PG/PLSQL codes here](https://github.com/Teekafey/Tech_Haven/blob/main/Triggers%20and%20Functions.sql)

```SQL
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
```

### Let us Test Stock Management:
```SQL
-- Check Initial Stock
SELECT id, name, stock FROM Products WHERE id = 1;
```
![image](https://github.com/user-attachments/assets/52832e92-cb9d-4431-ab86-ddbbe27ff418)

```SQL
-- Add Order Items 
INSERT INTO Orders (user_id, total_price, status) 
VALUES (2, 1999.99, 'pending');

-- Adds 2 Units 
INSERT INTO Order_Items (order_id, product_id, quantity, price)
VALUES (1, 1, 2, 1999.99);

-- Check Stock Again if the stock decreased:
SELECT id, name, stock FROM Products WHERE id = 1;
```
![product_reduce](https://github.com/user-attachments/assets/6329a25a-dbc3-477d-9af7-85a2570ba4be)

### 🔍 What Makes It Special
- Deep Database Integration: All product data, cart actions, and orders are powered by SQL queries, functions, triggers, and stored procedures.

- Minimal Backend: Just enough Flask to connect the frontend to the database — optimized for clarity and performance.

- Frontend Simplicity: Clean HTML/CSS/JS layout with no frontend framework, proving you don’t need React to be dynamic.

- Role-Specific Focus: As a DB dev, I wanted the data to do the talking. The frontend simply shows what the data says.

## THANK YOU!!🙏🏽
