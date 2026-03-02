#!/bin/bash
# entrypoint.sh
export SUPERSET_ENV=production

# Run database migrations
superset db upgrade

# Initialize Superset
superset init

# Start Superset with Gunicorn
exec gunicorn -w 2 -k gevent -b 0.0.0.0:${PORT:-8088} 'superset.app:create_app()'