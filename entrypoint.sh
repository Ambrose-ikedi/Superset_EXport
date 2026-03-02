#!/bin/bash
set -e

# Upgrade database
superset db upgrade

# Import dashboards and assets
superset import-assets -p /app/superset_export
# If using older format:
# superset import-dashboards -p /app/superset_export

# Initialize Superset (roles & permissions)
superset init

# Start Superset server
gunicorn \
    -b 0.0.0.0:8088 \
    --worker-class gevent \
    --workers 3 \
    "superset.app:create_app()"