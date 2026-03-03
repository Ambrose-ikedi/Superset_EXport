#!/bin/bash
set -e

# Initialize database
superset db upgrade

# Optional: create admin user if it doesn't exist
# superset fab create-admin \
#   --username admin \
#   --password admin \
#   --firstname Admin \
#   --lastname User \
#   --email admin@example.com

# Load default roles & permissions
superset init

# Start Superset web server on all interfaces
exec superset run -h 0.0.0.0 -p 8088 --with-threads --reload --debugger