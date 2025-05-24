#app/models.py
from app.db import get_connection

def fetch_weather_data():
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT city, temperature, timestamp FROM weather_data ORDER BY timestamp DESC LIMIT 10")
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return rows