# TechHaven

## TechHaven: Mini E-Commerce Web App for Tech Gadgets

TechHaven is a e-commerce platform built to showcase a database-centered architecture where every user action interacts directly with the underlying database. This project highlights my skills as a Database Developer by integrating PostgreSQL with a Flask backend and a minimal HTML/CSS/JavaScript frontend.

![image](https://github.com/user-attachments/assets/cad4272f-26fc-4e94-8b09-189cc9901253)


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
![ERD Diagram](https://github.com/user-attachments/assets/9a5a06c4-f46f-4fb3-be65-13b33a2764c2)

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

### 🖥️ Frontend (JS)
- Dynamic loading of products and order info
- Interactive cart UI (plus/minus buttons, remove, totals)
- Checkout and summary flow

---
**⭐ Star this repo if you find it useful or inspiring!**

