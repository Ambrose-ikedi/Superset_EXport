#!/bin/bash
set -e

# Upgrade DB & init Superset
superset db upgrade

# Create a public role for no-login dashboards
superset init

# Start Gunicorn with gevent worker
exec gunicorn -w 2 -k gevent -b 0.0.0.0:${PORT:-8088} "superset.app:create_app()"