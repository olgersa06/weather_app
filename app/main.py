#app/main.py
from flask import Flask, render_template
import psycopg2

app = Flask(__name__)

import psycopg2

def get_connection():
    return psycopg2.connect(
        host="10.2.0.4",  # Replace with internal load balancer IP
        database="weatherapp",
        user="admin",
        password="admin1234"
    )
def fetch_weather_data():
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT city, temperature, timestamp FROM weather_data ORDER BY timestamp DESC LIMIT 10")
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return rows

@app.route("/")
def home():
    data = fetch_weather_data()
    return render_template("index.html", data=data)

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0")