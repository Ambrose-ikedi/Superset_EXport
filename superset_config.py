# Superset configuration for Render with PostgreSQL

from superset.config import *  # inherit defaults

# Public dashboards (optional)
PUBLIC_ROLE_LIKE_GAMMA = True

# Upload folder
UPLOAD_FOLDER = "/tmp/uploads"

# Rate limiting
from flask_limiter.util import get_remote_address
RATELIMIT_STORAGE_URL = "memory://"

# Disable examples
LOAD_EXAMPLES = False