#!/bin/bash

apt-get update -y
apt-get install -y postgresql postgresql-contrib

# Starto dhe mundëso PostgreSQL
systemctl enable postgresql
systemctl start postgresql

# Krijo databazë dhe tabelë
sudo -u postgres psql <<EOF
CREATE DATABASE weatherdb;
\c weatherdb
CREATE TABLE weather_data (
    id SERIAL PRIMARY KEY,
    city TEXT NOT NULL,
    temperature INTEGER,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO weather_data (city, temperature) VALUES ('Tirana', 23);
EOF
