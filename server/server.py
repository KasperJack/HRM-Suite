from flask import Flask, jsonify, request
from functools import wraps

import psycopg2
from psycopg2 import sql
import json
from datetime import datetime
import jwt


app = Flask(__name__)

SECRET_KEY = "-super-secret-key55"
DB_CONFIG = {
    'host': 'localhost',
    'port': '5432',
    'database': 'testdb',
    'user': 'postgres',
    'password': ''  # Empty for trust authentication
}

def get_db_connection():
    """Get database connection"""
    try:
        connection = psycopg2.connect(**DB_CONFIG)
        return connection
    except psycopg2.Error as e:
        print(f"Database connection error: {e}")
 
        return None



@app.route('/api/health', methods=['GET'])
def health_check():
    """Health check endpoint"""
    return jsonify({
        'status': 'healthy',
        'timestamp': datetime.now().isoformat(),
        'service': 'User API'
    })



import jwt
import datetime

@app.route('/api/login', methods=['POST'])
def login():
    data = request.get_json()

    email = data.get('email')
    password = data.get('password')

    if not email or not password:
        return jsonify({'success': False, 'message': 'Email and password are required'}), 400

    conn = get_db_connection()
    if not conn:
        return jsonify({'success': False, 'message': 'Database connection failed'}), 500

    try:
        with conn.cursor() as cur:
            query = """
                SELECT id, full_name, c_level, photo
                FROM admins
                WHERE email = %s AND password = %s
                LIMIT 1
            """
            cur.execute(query, (email, password))
            result = cur.fetchone()

            if result:
                user_data = {
                    'id': result[0],
                    'full_name': result[1],
                    'c_level': result[2],
                    'photo': result[3]
                }

                #JWT token
                payload = {
                    'user_id': user_data['id'],
                    'exp': datetime.datetime.utcnow() + datetime.timedelta(hours=1)
                }
                token = jwt.encode(payload, SECRET_KEY, algorithm='HS256')

                return jsonify({
                    'success': True,
                    'message': 'Login successful',
                    'admin': user_data,
                    'token': token
                }), 200
            else:
                return jsonify({'success': False, 'message': 'Invalid credentials'}), 401

    except Exception as e:
        print("Login error:", e)
        return jsonify({'success': False, 'message': 'Internal server error'}), 500
    finally:
        conn.close()





















@app.errorhandler(404)
def not_found(error):
    return jsonify({'error': 'Endpoint not found'}), 404


@app.errorhandler(500)
def internal_error(error):
    return jsonify({'error': 'Internal server error'}), 500

if __name__ == '__main__':
    print("Starting User API Server...")
    
    # Initialize database
    #init_database()
    
    app.run(debug=True, host='0.0.0.0', port=5000)