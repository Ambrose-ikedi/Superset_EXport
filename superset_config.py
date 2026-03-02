# Path: superset_config.py

from cachelib.file import FileSystemCache
import os

# Bind Superset to Render port
SUPERSET_WEBSERVER_ADDRESS = "0.0.0.0"
SUPERSET_WEBSERVER_PORT = int(os.environ.get("PORT", 8088))

# Use PostgreSQL in production (replace with your Render Postgres credentials)
SQLALCHEMY_DATABASE_URI = os.environ.get(
    "DATABASE_URL",
    "postgresql+psycopg2://superset:superset@your-postgres-host:5432/superset"
)

# Flask Limiter for rate limiting
from flask_limiter.util import get_remote_address
RATELIMIT_STORAGE_URL = "memory://"

# Cache for dashboards
CACHE_CONFIG = {
    "CACHE_TYPE": "FileSystemCache",
    "CACHE_DIR": "/tmp/superset_cache",
    "CACHE_DEFAULT_TIMEOUT": 300,
}

# Disable CSRF for simplicity (optional)
WTF_CSRF_ENABLED = False

# Automatic dashboard import folder
DASHBOARD_EXPORT_PATH = "/app/superset_export"