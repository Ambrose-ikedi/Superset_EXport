import os

SECRET_KEY = os.environ.get("SUPERSET_SECRET_KEY", "supersecretkey")
SQLALCHEMY_DATABASE_URI = os.environ.get("SQLALCHEMY_DATABASE_URI")

FEATURE_FLAGS = {
    "EMBEDDED_SUPERSET": True,  # enable embedding dashboards
}

# Use Redis if configured
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

# Public guest user for dashboards
PUBLIC_USER_USERNAME = os.getenv("PUBLIC_USER_USERNAME", "public_user")
PUBLIC_USER_EMAIL = os.getenv("PUBLIC_USER_EMAIL", "public@example.com")
PUBLIC_USER_ROLE = "Public"