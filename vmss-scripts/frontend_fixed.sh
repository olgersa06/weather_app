#!/bin/bash

apt-get update -y
apt-get install -y python3 python3-pip nginx git

git clone https://github.com/olgersa06/weather_app.git /opt/weather_app

cd /opt/weather_app
pip3 install -r requirements.txt

cat <<EOF > /etc/systemd/system/weatherapp.service
[Unit]
Description=Weather App
After=network.target

[Service]
ExecStart=/usr/bin/python3 -m streamlit run app.py --server.port 8501 --server.enableCORS false
WorkingDirectory=/opt/weather_app
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reexec
systemctl daemon-reload
systemctl enable weatherapp
systemctl start weatherapp

cat <<EOF > /etc/nginx/sites-available/default
server {
    listen 80;

    location / {
        proxy_pass http://localhost:8501;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

systemctl restart nginx
