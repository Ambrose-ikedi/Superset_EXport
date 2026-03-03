# Use official Superset image
FROM apache/superset:latest

# Switch to root to install dependencies
USER root

# Install Postgres driver globally
RUN pip install --no-cache-dir psycopg2-binary

# Set working directory
WORKDIR /app

# Copy your Superset config and scripts
COPY superset_config.py /app/pythonpath/superset_config.py
COPY entrypoint.sh /app/entrypoint.sh
COPY superset_export /app/superset_export

# Make entrypoint executable
RUN chmod +x /app/entrypoint.sh

# Expose Superset default port
EXPOSE 8088

# Switch back to superset user for security
USER superset

# Run entrypoint
CMD ["/app/entrypoint.sh"]