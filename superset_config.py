import os

# ---------------------------
# Secret Key & Database URI
# ---------------------------
SECRET_KEY = os.environ["SUPERSET_SECRET_KEY"]
SQLALCHEMY_DATABASE_URI = os.environ["SQLALCHEMY_DATABASE_URI"]

# ---------------------------
# Feature Flags
# ---------------------------
FEATURE_FLAGS = {
    "EMBEDDED_SUPERSET": True,
}

# ---------------------------
# Redis Configuration (Optional)
# ---------------------------
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

# ---------------------------
# Superset Webserver Port (Render auto-sets $PORT)
# ---------------------------
SUPERSET_WEBSERVER_PORT = int(os.environ.get("PORT", 8088))

# ---------------------------
# Web Concurrency (Render default 1)
# ---------------------------
WEB_CONCURRENCY = int(os.environ.get("WEB_CONCURRENCY", 1))