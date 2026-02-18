import os

# Secret key for Superset
SECRET_KEY = os.getenv("SUPERSET_SECRET_KEY", "changeme")

# Database for Superset metadata
SQLALCHEMY_DATABASE_URI = os.getenv("DATABASE_URL", "sqlite:////app/superset.db")

# Optional feature flags
FEATURE_FLAGS = {
    "EMBEDDED_SUPERSET": True,
}

# Redis configuration for caching & Celery
REDIS_HOST = os.getenv("REDIS_HOST", "localhost")
REDIS_PORT = os.getenv("REDIS_PORT", 6379)

CACHE_CONFIG = {
    "CACHE_TYPE": "RedisCache",
    "CACHE_DEFAULT_TIMEOUT": 300,
    "CACHE_REDIS_HOST": REDIS_HOST,
    "CACHE_REDIS_PORT": REDIS_PORT,
    "CACHE_REDIS_DB": 1,
}

CELERY_BROKER_URL = f"redis://{REDIS_HOST}:{REDIS_PORT}/0"
CELERY_RESULT_BACKEND = f"redis://{REDIS_HOST}:{REDIS_PORT}/0"
