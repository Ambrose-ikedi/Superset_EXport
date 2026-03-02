#!/bin/bash
set -e
echo "🚀 Starting Superset container..."

# Upgrade DB
echo "🔹 Upgrading database..."
superset db upgrade

# Initialize Superset
echo "🔹 Initializing Superset..."
superset init

# Create admin if not exists
ADMIN_USERNAME=${SUPERSET_ADMIN_USERNAME:-admin}
ADMIN_PASSWORD=${SUPERSET_ADMIN_PASSWORD:-admin}
ADMIN_EMAIL=${SUPERSET_ADMIN_EMAIL:-admin@superset.com}

if ! superset fab list-users | grep -q "$ADMIN_USERNAME"; then
    echo "🔹 Creating admin user: $ADMIN_USERNAME"
    superset fab create-admin \
      --username "$ADMIN_USERNAME" \
      --password "$ADMIN_PASSWORD" \
      --firstname Superset \
      --lastname Admin \
      --email "$ADMIN_EMAIL"
else
    echo "🔹 Admin user already exists."
fi

# Start Gunicorn
echo "🔹 Launching Superset with Gunicorn..."
exec gunicorn \
    --bind 0.0.0.0:8088 \
    --workers ${WEB_CONCURRENCY:-1} \
    --worker-class gthread \
    "superset.app:create_app()"