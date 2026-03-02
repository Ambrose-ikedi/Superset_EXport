#!/bin/bash
set -e

# 1️⃣ Upgrade database
superset db upgrade

# 2️⃣ Create admin user if missing
superset fab create-admin \
    --username admin \
    --firstname Admin \
    --lastname User \
    --email admin@example.com \
    --password Admin123 || true

# 3️⃣ Initialize Superset
superset init

# 4️⃣ Import dashboards with admin user
if [ -d "/app/superset_export" ]; then
    echo "Importing dashboards from /app/superset_export..."
    superset import-dashboards -p /app/superset_export -u admin || true
fi

# 5️⃣ Start Superset on Render port
echo "Starting Superset on port ${PORT:-8088}..."
exec gunicorn \
    --bind 0.0.0.0:${PORT:-8088} \
    --workers 3 \
    --timeout 120 \
    "superset.app:create_app()"