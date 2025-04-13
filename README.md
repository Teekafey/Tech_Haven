# TechHaven

## TechHaven: Mini E-Commerce Web App for Tech Gadgets

TechHaven is a e-commerce platform built to showcase a database-centered architecture where every user action interacts directly with the underlying database. This project highlights my skills as a Database Developer by integrating PostgreSQL with a Flask backend and a minimal HTML/CSS/JavaScript frontend.

💭**Thought** : I wanted to build a project that truly shows what a great database looks like in action. This is it.

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
- Relational schema with tables like:
  - `products`, `users`, `cart`, `orders`, `order_items`, `reviews`, `suppliers`, `categories`
- **Advanced SQL Logic**:
  - Triggers to prevent out-of-stock orders
  - Stored Procedures to process orders
  - Functions for cart totals

### 🧩 API Endpoints (Flask)
- `GET /api/products` – Fetch all products
- `GET /api/products/<id>` – Fetch product details
- `GET /api/cart?user_id=1` – Get cart for a user
- `GET /api/order-summary?user_id=1` – Get latest order summary

### 🖥️ Frontend (Vanilla JS)
- Dynamic loading of products and order info
- Interactive cart UI (plus/minus buttons, remove, totals)
- Checkout and summary flow

---
**⭐ Star this repo if you find it useful or inspiring!**

