# Import libraries
from urllib import request
from flask import Flask, jsonify
from flask import Flask, request, jsonify
import psycopg2
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # Allows frontend to make requests

# Database connection
DB_CONFIG = {
    "dbname": "TechHaven",
    "user": "user",
    "password": "****",
    "host": "yourhost",
    "port": "***"
}

def connect_db():
    return psycopg2.connect(**DB_CONFIG)

# API to fetch all products
@app.route('/api/products', methods=['GET'])
def get_products():
    conn = connect_db()
    cur = conn.cursor()

    cur.execute("SELECT id, name, description, price, stock, image_url, price_old FROM products")
    products = cur.fetchall()

    cur.close()
    conn.close()

    product_list = [
        {"id": p[0], "name": p[1], "description": p[2], "price": p[3], "stock": p[4], "image_url": p[5], "price_old": p[6] }
        for p in products
    ]
    
    return jsonify(product_list)
  
# API to fetch cart detais
@app.route('/api/cart', methods=['GET'])
def get_cart():
    conn = connect_db()
    cur = conn.cursor()

    cur.execute("""
        SELECT c.id, p.name AS product_name, p.image_url, c.quantity, p.price, p.color
        FROM cart c
        JOIN products p ON c.product_id = p.id
    """)
    cart_items = cur.fetchall()

    cur.close()
    conn.close()

    cart_list = [
        {
            "id": c[0], 
            "product_name": c[1], 
            "image_url": c[2], 
            "quantity": c[3], 
            "price": c[4],
            "color": c[5]
        }
        for c in cart_items
    ]

    return jsonify(cart_list)

# API to fetch all product details
@app.route('/api/products/<int:product_id>', methods=['GET'])
def get_product_details(product_id):
    conn = connect_db()
    cur = conn.cursor()

    cur.execute("SELECT id, name, description, price, stock, image_url FROM products WHERE id = %s", (product_id,))
    product = cur.fetchone()

    cur.close()
    conn.close()

    if product:
        product_data = {
            "id": product[0],
            "name": product[1],
            "description": product[2],
            "price": product[3],
            "stock": product[4],
            "image_url": product[5]
        }
        return jsonify(product_data)
    else:
        return jsonify({"error": "Product not found"}), 404

# API to fetch order summary
@app.route('/api/order-summary', methods=['GET'])
def order_summary():
    user_id = request.args.get('user_id', type=int)

    if not user_id:
        return jsonify({"error": "User ID is required"}), 400  # Handle missing user_id

    conn = connect_db()
    cur = conn.cursor()

    cur.execute("""
        SELECT o.id AS order_id, p.name AS product_name, p.color, p.price, oi.quantity, 
               u.full_name, u.address, u.city, u.zip, u.country
        FROM orders o
        JOIN order_items oi ON o.id = oi.order_id
        JOIN products p ON oi.product_id = p.id
        JOIN users u ON o.user_id = u.id
        WHERE o.user_id = %s  
        ORDER BY o.created_at DESC
        LIMIT 1
    """, (user_id,))

    order_data = cur.fetchall()
    cur.close()
    conn.close()

    if not order_data:
        return jsonify({"error": "No order found"}), 404

    # Debugging print
    print("Fetched order data:", order_data)

    order_summary = {
        "order_id": f"{order_data[0][0]:03d}",
        "shipping_info": {
            "full_name": order_data[0][5],
            "address": order_data[0][6],
            "city": order_data[0][7],
            "zip": order_data[0][8],
            "country": order_data[0][9],
        },
        "products": [
            {
                "product_name": item[1],
                "color": item[2],
                "price": item[3],
                "quantity": item[4]
            }
            for item in order_data
        ],
        "total_amount": sum(item[3] * item[4] for item in order_data)
    }

    return jsonify(order_summary)


if __name__ == '__main__':
    app.run(debug=True)

#############
