# Minimal superset config to disable login for public dashboards
# Place this at /app/pythonpath/superset_config.py

from flask_appbuilder.security.manager import AUTH_DB

# Disable authentication
AUTH_TYPE = AUTH_DB
AUTH_USER_REGISTRATION = True
AUTH_USER_REGISTRATION_ROLE = "Admin"

# Optional: allow public dashboards without login
PUBLIC_ROLE_LIKE_GAMMA = True

# Increase concurrency
SUPERSET_WORKERS = 3
SUPERSET_WEBSERVER_PORT = 8088
SUPERSET_WEBSERVER_ADDRESS = "0.0.0.0"