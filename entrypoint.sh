#!/bin/bash

echo "Starting Superset..."

superset db upgrade

superset fab create-admin \
--username admin \
--firstname Superset \
--lastname Admin \
--email admin@superset.com \
--password admin || true

superset init

echo "Importing dashboards..."

superset import-assets \
--path /app/superset_export \
--username admin || true

echo "Starting server..."

gunicorn \
--bind 0.0.0.0:8088 \
--workers 1 \
--timeout 120 \
"superset.app:create_app()"