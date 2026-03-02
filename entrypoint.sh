#!/bin/bash
# entrypoint.sh for Render + Superset production

set -e  # exit on error
echo "🚀 Starting Superset container..."

# 1️⃣ Initialize Superset DB if not already
echo "🔹 Upgrading database..."
superset db upgrade

# 2️⃣ Initialize Superset (roles, permissions, defaults)
echo "🔹 Initializing Superset..."
superset init

# 3️⃣ Create admin user if it doesn't exist
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

# 4️⃣ Start Gunicorn (Render sets WEB_CONCURRENCY automatically)
echo "🔹 Launching Superset with Gunicorn..."
exec gunicorn \
    --bind 0.0.0.0:8088 \
    --workers ${WEB_CONCURRENCY:-1} \
    --worker-class gthread \
    "superset.app:create_app()"