#!/bin/bash
set -e

# Run migrations
superset db upgrade

# Initialize Superset
superset init

# Start Gunicorn with gevent worker
exec gunicorn -w 2 -k gevent -b 0.0.0.0:${PORT:-8088} "superset.app:create_app()"