-- DDL OPERATIONS
-- Create Users Table (Customers & Admins)
CREATE TABLE Users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) CHECK (role IN ('customer', 'admin')) DEFAULT 'customer'
);

-- Create Categories Table
CREATE TABLE Categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

-- Create Products Table
CREATE TABLE Products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    image VARCHAR(255),
    category_id INT REFERENCES Categories(id) ON DELETE SET NULL
);

-- Create Cart Table (Temporary Storage Before Checkout)
CREATE TABLE Cart (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Users(id) ON DELETE CASCADE,
    product_id INT REFERENCES Products(id) ON DELETE CASCADE,
    quantity INT CHECK (quantity > 0) NOT NULL DEFAULT 1
);

-- Create Orders Table
CREATE TABLE Orders (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Users(id) ON DELETE CASCADE,
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) CHECK (status IN ('pending', 'shipped', 'delivered', 'canceled')) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Order_Items Table (Products Purchased in an Order)
CREATE TABLE Order_Items (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES Orders(id) ON DELETE CASCADE,
    product_id INT REFERENCES Products(id) ON DELETE CASCADE,
    quantity INT CHECK (quantity > 0) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

-- Create Reviews Table (Users Can Review Products)
CREATE TABLE Reviews (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Users(id) ON DELETE CASCADE,
    product_id INT REFERENCES Products(id) ON DELETE CASCADE,
    rating INT CHECK (rating BETWEEN 1 AND 5) NOT NULL,
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Shipping Addresses Table
CREATE TABLE Shipping_Addresses (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Users(id) ON DELETE CASCADE,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    zip_code VARCHAR(20) NOT NULL
);

-- Create Payments Table (Basic Logging of Transactions)
CREATE TABLE Payments (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES Orders(id) ON DELETE CASCADE,
    amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) CHECK (status IN ('pending', 'completed', 'failed')) DEFAULT 'pending',
    payment_method VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Add an image_url Column to products table
ALTER TABLE products ADD COLUMN image_url TEXT;
ALTER TABLE products ADD COLUMN price_old DECIMAL(10,2);
ALTER TABLE products ADD COLUMN color TEXT;

-- Rename users name and add address columns
ALTER TABLE users RENAME COLUMN name to full_name ;
ALTER TABLE users ADD COLUMN address TEXT;
ALTER TABLE users ADD COLUMN city VARCHAR(100);
ALTER TABLE users ADD COLUMN zip VARCHAR(10);
ALTER TABLE users ADD COLUMN country VARCHAR(50);



--DML OPERATIONS
-- Insert Categories
INSERT INTO Categories (name) VALUES 
('Laptops'), 
('Smartphones'), 
('Accessories');

-- Insert Sample Products
INSERT INTO Products (name, description, price, stock, image, category_id) VALUES
('MacBook Pro', 'Apple MacBook Pro with M2 chip', 1999.99, 10, 'macbook.jpg', 1),
('iPhone 14', 'Latest Apple iPhone 14', 999.99, 20, 'iphone14.jpg', 2),
('Wireless Headphones', 'Noise-canceling headphones', 199.99, 15, 'headphones.jpg', 3);

-- Insert Sample Users
INSERT INTO Users (name, email, password, role) VALUES
('John Doe', 'john@example.com', 'hashed_password_here', 'customer'),
('Admin User', 'admin@example.com', 'hashed_password_here', 'admin');

-- Insert a Sample Order
INSERT INTO Orders (user_id, total_price, status) VALUES (1, 2199.98, 'pending');

-- Insert Order Items (Products in the Order)
INSERT INTO Order_Items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 1999.99),
(1, 3, 1, 199.99);

-- Insert a Sample Cart Entry
INSERT INTO Cart (user_id, product_id, quantity) VALUES (1, 2, 1);
INSERT INTO Cart (user_id, product_id, quantity) VALUES (2, 1, 1);

-- Insert a Sample Shipping Address
INSERT INTO Shipping_Addresses (user_id, address, city, state, zip_code) VALUES
(1, '123 Tech Street', 'New York', 'NY', '10001');

-- Insert a Sample Payment
INSERT INTO Payments (order_id, amount, status, payment_method) VALUES
(1, 2199.98, 'completed', 'Credit Card');



-- Update Address Data
UPDATE users 
SET address = '6, Allen Str',
    city = 'Lagos',
	zip = 112155,
	country = 'Nigeria'
WHERE ID = 1;

UPDATE users 
SET address = '24, Oyo Str',
    city = 'Lagos',
	zip = 313215,
	country = 'Nigeria'
WHERE ID = 2;

-- Update Image URLs and Product Descriptions
UPDATE products 
SET image_url = 'https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D.png' 
WHERE id = 1;

UPDATE products 
SET image_url = 'https://images.unsplash.com/photo-1664478546384-d57ffe74a78c?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D.png' 
WHERE id = 2;

UPDATE products 
SET image_url = 'https://images.unsplash.com/photo-1549206464-82c129240d11?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D.png' 
WHERE id = 3;

-- Update Old prices
UPDATE products 
SET price_old = 2099
WHERE id =1;

UPDATE products 
SET price_old = 1099
WHERE id =2;

UPDATE products 
SET price_old = 299
WHERE id =3;

-- Update Product details
UPDATE products 
SET color = 'Purple'
WHERE id = 2;

UPDATE products 
SET color = 'Silver'
WHERE id = 1;



------------------------------

