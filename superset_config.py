import os

# SECRET_KEY can be random for session security
SECRET_KEY = os.environ.get("SUPERSET_SECRET_KEY", "my-super-secret-key")

# Postgres database URL (set in Render environment)
SQLALCHEMY_DATABASE_URI = os.environ.get(
    "SQLALCHEMY_DATABASE_URI",
    "postgresql+psycopg2://user:password@host:5432/dbname"
)

# Enable embedded Superset (useful for dashboards)
FEATURE_FLAGS = {
    "EMBEDDED_SUPERSET": True,
}

# Public dashboard: skip authentication
AUTH_TYPE = None
AUTH_ROLE_PUBLIC = "Gamma"  # minimum read-only role

# Cache & broker settings
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