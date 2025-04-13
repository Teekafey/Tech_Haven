# Tech_Haven

## TechHaven: E-Commerce Web App for Tech Gadgets

TechHaven is a full-stack e-commerce platform built to showcase a database-centered architecture where every user action interacts directly with the underlying database. This project highlights my skills as a Database Developer by integrating PostgreSQL with a Flask backend and a clean HTML/CSS/JavaScript frontend.

---

## 🚀 Live Features
- **Homepage** dynamically loads all products from PostgreSQL.
- **Product View Page** displays all product details fetched from the database.
- **Cart Page** allows real-time cart management (Add, Remove, Update Quantity).
- **Order Summary Page** displays user shipping information and order details.

---

## 💡 Tech Stack
- **Frontend:** HTML, CSS, JavaScript (Fetch API)
- **Backend:** Python Flask (REST API)
- **Database:** PostgreSQL (with advanced SQL logic)

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
- `POST /api/update-cart` – Add/update cart items
- `DELETE /api/remove-cart-item` – Remove item from cart
- `POST /api/checkout` – Process order
- `GET /api/order-summary?user_id=1` – Get latest order summary

### 🖥️ Frontend (Vanilla JS)
- Dynamic loading of products and order info
- Interactive cart UI (plus/minus buttons, remove, totals)
- Checkout and summary flow

---

## 📸 Screenshots
- Homepage with live product feed
- Product details on click
- Cart with quantity control
- Order summary with user info and item breakdown

---

## 📦 Setup & Run Locally
```bash
# Clone the repository
git clone https://github.com/yourusername/techhaven.git
cd techhaven

# Backend
cd backend
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
python app.py

# Frontend
Open index.html in your browser
```

---

## 🛠️ Highlights for Recruiters
- Deep focus on **database interaction** and backend logic.
- Minimalistic but clean frontend to visualize data flow.
- Proof of understanding **stored procedures, triggers, and SQL optimization**.
- Complete user interaction cycle — from browsing to checkout.

---

## 🙌 Author
**Samuel — Aspiring Database Developer**

> "I wanted to build a project that truly shows what a great database looks like in action. This is it."

---

## 📫 Feedback / Questions
Reach out via [LinkedIn](#) or open an issue on GitHub.

---

**⭐ Star this repo if you find it useful or inspiring!**

