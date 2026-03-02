#!/bin/bash
set -e

# Create admin user (skip if exists)
superset fab create-admin \
    --username admin \
    --firstname Admin \
    --lastname User \
    --email admin@example.com \
    --password Admin123 || true

# Upgrade database
superset db upgrade

# Import dashboards automatically
if [ -d "/app/superset_export" ]; then
    echo "Importing dashboards from /app/superset_export..."
    superset import-dashboards \
        --path /app/superset_export \
        --username admin
fi

# Initialize Superset
superset init

# Start gunicorn using Render's $PORT
exec gunicorn -w 3 -k gevent --timeout 120 -b 0.0.0.0:$PORT "superset.app:create_app()"