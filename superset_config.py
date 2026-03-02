import os

SECRET_KEY = os.environ.get("SUPERSET_SECRET_KEY", "changeme")
SQLALCHEMY_DATABASE_URI = os.environ.get(
    "SQLALCHEMY_DATABASE_URI",
    "sqlite:////app/superset.db"
)

FEATURE_FLAGS = {
    "EMBEDDED_SUPERSET": True,
}

# Cache
REDIS_HOST = os.getenv("REDIS_HOST_KEY")
REDIS_PORT = int(os.getenv("REDIS_PORT_KEY", 6379))

if REDIS_HOST:
    CACHE_CONFIG = {
        "CACHE_TYPE": "RedisCache",
        "CACHE_DEFAULT_TIMEOUT": 300,
        "CACHE_REDIS_HOST": REDIS_HOST,
        "CACHE_REDIS_PORT": REDIS_PORT,
        "CACHE_REDIS_DB": 1,
    }
    CELERY_BROKER_URL = f"redis://{REDIS_HOST}:{REDIS_PORT}/0"
    CELERY_RESULT_BACKEND = f"redis://{REDIS_HOST}:{REDIS_PORT}/0"
else:
    CACHE_CONFIG = {
        "CACHE_TYPE": "SimpleCache",
        "CACHE_DEFAULT_TIMEOUT": 300,
    }
    CELERY_BROKER_URL = None
    CELERY_RESULT_BACKEND = None

# -----------------------------
# Public dashboards without login
# -----------------------------
from superset.security import SupersetSecurityManager
from flask_appbuilder.security.manager import AUTH_DB

# Use normal DB auth but we will create a 'public' user automatically
AUTH_TYPE = AUTH_DB
AUTH_USER_REGISTRATION = True
AUTH_USER_REGISTRATION_ROLE = "Gamma"

PUBLIC_ROLE_LIKE_GAMMA = True