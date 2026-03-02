import logging

# Use "null" auth to allow public access without login
from superset.security import SupersetSecurityManager
from flask_appbuilder.security.manager import AUTH_REMOTE_USER

# Disable authentication
AUTH_TYPE = AUTH_REMOTE_USER
CUSTOM_SECURITY_MANAGER = SupersetSecurityManager

# Database connection (update your Postgres URL)
SQLALCHEMY_DATABASE_URI = "postgresql+psycopg2://username:password@host:5432/dbname"

# Feature flags
FEATURE_FLAGS = {
    "EMBEDDED_SUPERSET": True,
}

# Cache (optional, use Redis if available)
REDIS_HOST = None
REDIS_PORT = 6379

if REDIS_HOST:
    CACHE_CONFIG = {
        "CACHE_TYPE": "RedisCache",
        "CACHE_DEFAULT_TIMEOUT": 300,
        "CACHE_REDIS_HOST": REDIS_HOST,
        "CACHE_REDIS_PORT": REDIS_PORT,
        "CACHE_REDIS_DB": 1,
    }
else:
    CACHE_CONFIG = {
        "CACHE_TYPE": "SimpleCache",
        "CACHE_DEFAULT_TIMEOUT": 300,
    }

# Logging
LOGGING_LEVEL = logging.INFO