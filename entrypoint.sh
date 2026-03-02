#!/bin/bash
set -e

# 1️⃣ Upgrade database
superset db upgrade

# 2️⃣ Create admin user (if it doesn't exist)
superset fab create-admin \
    --username admin \
    --firstname Admin \
    --lastname User \
    --email admin@example.com \
    --password Admin123

# 3️⃣ Initialize Superset
superset init

# 4️⃣ Import dashboards, charts, datasets from your export folder
if [ -d "/app/superset_export" ]; then
    echo "Importing dashboards from /app/superset_export..."
    superset import-dashboards -p /app/superset_export || true
fi

# 5️⃣ Start Superset in production mode
exec gunicorn \
    --bind 0.0.0.0:8088 \
    --workers 3 \
    --timeout 120 \
    "superset.app:create_app()"