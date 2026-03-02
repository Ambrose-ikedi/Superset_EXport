import os

# Use environment variables for DB
SQLALCHEMY_DATABASE_URI = os.environ.get(
    "SUPERSET_DATABASE_URI",
    "postgresql+psycopg2://user:password@localhost:5432/superset"
)

SECRET_KEY = os.environ.get("SUPERSET_SECRET_KEY", "change-me")

# Optional: Disable SQLite caching warnings
CACHE_CONFIG = {
    "CACHE_TYPE": "SimpleCache",
}