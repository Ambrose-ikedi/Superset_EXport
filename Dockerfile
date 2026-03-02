# Use official Superset image
FROM apache/superset:latest

# Switch to root to install dependencies
USER root

# Upgrade pip and install Python packages in the Superset venv
RUN /usr/local/bin/python3 -m pip install --upgrade pip \
    && /usr/local/bin/python3 -m pip install \
        psycopg2-binary>=2.9.7 \
        redis>=5.0.0 \
        gevent>=21.1.2 \
        flask-limiter>=2.9.0 \
        pandas>=2.0.3 \
        numpy>=1.25.0

# Copy Superset config
COPY superset_config.py /app/pythonpath/superset_config.py

# Copy entrypoint script
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Set environment variables
ENV SUPERSET_CONFIG_PATH=/app/pythonpath/superset_config.py
ENV PYTHONPATH=/app/pythonpath

# Switch back to superset user
USER superset

# Use custom entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]