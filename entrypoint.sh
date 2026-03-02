#!/bin/bash
set -e

echo "Waiting for PostgreSQL to be ready..."
until pg_isready -d "$DATABASE_URL"; do
  echo "Postgres not ready, sleeping 2s..."
  sleep 2
done

echo "PostgreSQL is ready."

echo "Upgrading database..."
superset db upgrade

echo "Creating admin user..."
superset fab create-admin \
  --username "$SUPERSET_ADMIN_USERNAME" \
  --password "$SUPERSET_ADMIN_PASSWORD" \
  --firstname "$SUPERSET_ADMIN_FIRST_NAME" \
  --lastname "$SUPERSET_ADMIN_LAST_NAME" \
  --email "$SUPERSET_ADMIN_EMAIL" || true

echo "Initializing Superset..."
superset init

# Optional: import dashboards if folder exists
if [ -d "/app/superset_export" ]; then
  echo "Importing dashboards..."
  superset import-dashboards -p /app/superset_export -u "$SUPERSET_ADMIN_USERNAME" -f || true
fi

echo "Starting Gunicorn..."
exec gunicorn -w 4 -b 0.0.0.0:8088 "superset.app:create_app()"