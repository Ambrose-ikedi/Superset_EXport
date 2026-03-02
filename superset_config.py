from superset.config import *  # default config

# Optional: disable login to make dashboards public
# WARNING: Public dashboards are fully accessible without auth
PUBLIC_ROLE_LIKE_GAMMA = True
AUTH_ROLE_PUBLIC = 'Public'

# Optional: use SQLite (default)
SQLALCHEMY_DATABASE_URI = 'sqlite:////app/superset.db'

# Optional: Superset feature flags
FEATURE_FLAGS = {
    "ENABLE_TEMPLATE_PROCESSING": True,
}