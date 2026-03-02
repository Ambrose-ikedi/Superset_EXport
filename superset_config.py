import os

# Database (Postgres)
SQLALCHEMY_DATABASE_URI = os.environ.get(
    "SUPERSET_DATABASE_URI",
    "postgresql+psycopg2://superset:superset@db:5432/superset"
)

# Feature flags & caching
FEATURE_FLAGS = {
    "ALERT_REPORTS": True,
    "DASHBOARD_NATIVE_FILTERS": True,
}
CACHE_CONFIG = {
    'CACHE_TYPE': 'RedisCache',
    'CACHE_DEFAULT_TIMEOUT': 300,
    'CACHE_KEY_PREFIX': 'superset_',
    'CACHE_REDIS_URL': os.environ.get("REDIS_URL", "redis://redis:6379/0")
}

# Secret key
SECRET_KEY = os.environ.get("SUPERSET_SECRET_KEY", "SuperSecretKey123")

# Enable CSRF protection
WTF_CSRF_ENABLED = True