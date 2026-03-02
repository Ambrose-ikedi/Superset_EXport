import os

# Use Postgres as the metadata database
SQLALCHEMY_DATABASE_URI = os.getenv("DATABASE_URL")

# Superset settings
SECRET_KEY = os.getenv("SUPERSET_SECRET_KEY", "this-is-a-secret-key")
ENABLE_PROXY_FIX = True
WEBSERVER_THREADS = 8
SUPERSET_WEBSERVER_PORT = int(os.getenv("SUPERSET_PORT", 8088))