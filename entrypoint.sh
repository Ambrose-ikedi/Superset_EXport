#!/bin/bash
set -e

# Wait for Postgres to be ready
echo "Waiting for Postgres..."
until pg_isready -h $POSTGRES_HOST -p $POSTGRES_PORT -U $POSTGRES_USER; do
  sleep 2
done
echo "Postgres is ready!"

# Initialize Superset DB
superset db upgrade

# Create admin user (only if it doesn't exist)
superset fab create-admin \
  --username admin \
  --firstname Admin \
  --lastname User \
  --email admin@example.com \
  --password admin

# One-time import of dashboards (if file exists)
if [ -f /app/superset_export/dashboards_export.json ]; then
  echo "Importing dashboards..."
  superset import-dashboards -p /app/superset_export/dashboards_export.json -u admin
fi

# Initialize Superset
superset init

# Start Gunicorn web server
exec gunicorn \
    --bind 0.0.0.0:8088 \
    --workers ${WEB_CONCURRENCY:-2} \
    "superset.app:create_app()"