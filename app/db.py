#app/db.py
import psycopg2

def get_connection():
    return psycopg2.connect(
        host="10.2.0.4",  # Replace with internal load balancer IP
        database="weatherapp",
        user="admin",
        password="admin1234"
    )