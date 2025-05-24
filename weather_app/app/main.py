#app/main.py
from flask import Flask, render_template
from app.models import fetch_weather_data

app = Flask(__name__)

@app.route("/")
def home():
    data = fetch_weather_data()
    return render_template("index.html", data=data)

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0")