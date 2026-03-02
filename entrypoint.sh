#!/bin/bash

echo "Starting Superset..."

superset db upgrade

superset fab create-admin \
 --username admin \
 --firstname Admin \
 --lastname User \
 --email admin@example.com \
 --password admin || true

superset init

echo "Importing dashboards..."

superset import-assets \
    -p /app/superset_export

echo "Starting Superset Server..."

gunicorn \
 -w 2 \
 -k gevent \
 -b 0.0.0.0:$PORT \
 "superset.app:create_app()"