FROM apache/superset:latest

USER root

# Install system dependencies if needed
RUN apt-get update && apt-get install -y build-essential libpq-dev

# Install Python dependencies
RUN python3 -m venv /app/.venv
RUN /app/.venv/bin/pip install --upgrade pip
RUN /app/.venv/bin/pip install \
    psycopg2-binary \
    redis \
    gevent

# Copy Superset config and entrypoint
COPY superset_config.py /app/pythonpath/superset_config.py
COPY entrypoint.sh /app/entrypoint.sh

# Set environment variables
ENV SUPERSET_CONFIG_PATH=/app/pythonpath/superset_config.py
ENV PYTHONPATH=/app/pythonpath

# Set executable and working user
RUN chmod +x /app/entrypoint.sh
USER superset

# Entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]