#!/bin/bash
set -e

echo "Running Superset migrations..."
superset db upgrade

echo "Initializing Superset..."
superset init

# Create a guest user if AUTH_TYPE=0
if [ "$AUTH_TYPE" == "0" ]; then
    echo "Creating guest role..."
    superset fab create-role --role-name Public --permissions-from gamma || true
fi

echo "Starting Superset server..."
exec gunicorn -w 2 -k gevent -b 0.0.0.0:${PORT:-8088} "superset.app:create_app()"