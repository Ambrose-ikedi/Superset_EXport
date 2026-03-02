#!/bin/bash
set -e

# Initialize database if not already
superset db upgrade

# Create admin user if not exists
export ADMIN_USERNAME=${ADMIN_USERNAME:-admin}
export ADMIN_PASSWORD=${ADMIN_PASSWORD:-admin}
export ADMIN_FIRST_NAME=${ADMIN_FIRST_NAME:-Admin}
export ADMIN_LAST_NAME=${ADMIN_LAST_NAME:-User}
export ADMIN_EMAIL=${ADMIN_EMAIL:-admin@example.com}

superset fab create-admin \
    --username "$ADMIN_USERNAME" \
    --firstname "$ADMIN_FIRST_NAME" \
    --lastname "$ADMIN_LAST_NAME" \
    --email "$ADMIN_EMAIL" \
    --password "$ADMIN_PASSWORD" || true

# Import dashboards, charts, datasets from the export folder
if [ -d "/app/superset_export" ]; then
    superset import-dashboards \
        -p /app/superset_export \
        -u "$ADMIN_USERNAME"
fi

# Initialize Superset
superset init

# Start Gunicorn on Render port
exec gunicorn \
    --bind 0.0.0.0:${PORT:-8088} \
    --workers 3 \
    --timeout 120 \
    "superset.app:create_app()"