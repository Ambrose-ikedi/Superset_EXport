#!/bin/bash
set -e

# Function to wait for Postgres to be ready
wait_for_postgres() {
  echo "Waiting for PostgreSQL to be ready..."
  until pg_isready -d "$DATABASE_URL"; do
    echo "Postgres not ready, sleeping 2s..."
    sleep 2
  done
  echo "PostgreSQL is ready."
}

# Function to create admin user safely
create_admin_user() {
  echo "Creating admin user..."
  superset fab create-admin \
    --username "$SUPERSET_ADMIN_USERNAME" \
    --password "$SUPERSET_ADMIN_PASSWORD" \
    --firstname "$SUPERSET_ADMIN_FIRST_NAME" \
    --lastname "$SUPERSET_ADMIN_LAST_NAME" \
    --email "$SUPERSET_ADMIN_EMAIL" || echo "Admin user may already exist."
}

# Function to initialize Superset
initialize_superset() {
  echo "Upgrading database..."
  superset db upgrade

  echo "Initializing Superset..."
  superset init
}

# Function to import dashboards with retries
import_dashboards() {
  DASHBOARD_PATH="/app/superset_export"
  if [ -d "$DASHBOARD_PATH" ]; then
    echo "Importing dashboards from $DASHBOARD_PATH..."
    # Retry up to 3 times if import fails
    for i in 1 2 3; do
      superset import-dashboards -p "$DASHBOARD_PATH" -u "$SUPERSET_ADMIN_USERNAME" -f && break
      echo "Import failed on attempt $i. Retrying in 3s..."
      sleep 3
    done
  else
    echo "No dashboards folder found at $DASHBOARD_PATH, skipping import."
  fi
}

# Function to start Superset Gunicorn server
start_server() {
  echo "Starting Gunicorn..."
  exec gunicorn -w 4 -b 0.0.0.0:8088 "superset.app:create_app()"
}

# ---- Main Execution ----
wait_for_postgres
initialize_superset
create_admin_user
import_dashboards
start_server