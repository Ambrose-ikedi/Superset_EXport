import os

# Secret key for Flask sessions
SECRET_KEY = os.environ.get("SUPERSET_SECRET_KEY", "supersecretkey")

# Database connection
SQLALCHEMY_DATABASE_URI = os.environ.get(
    "SQLALCHEMY_DATABASE_URI",
    "sqlite:///:memory:"  # fallback
)

# Feature flags
FEATURE_FLAGS = {
    "EMBEDDED_SUPERSET": True,
}

# Allow public dashboards (no login)
AUTH_TYPE = 0  # 0 = No authentication
PUBLIC_ROLE_LIKE_GAMMA = True  # guest access to dashboards
ENABLE_PROXY_FIX = True

# Caching
REDIS_HOST = os.environ.get("REDIS_HOST_KEY")
REDIS_PORT = int(os.environ.get("REDIS_PORT_KEY", 6379))

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