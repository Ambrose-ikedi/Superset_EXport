# Start from the official Superset image
FROM apache/superset:latest

# Set workdir
WORKDIR /app

# Install Postgres client
USER root
RUN apt-get update && apt-get install -y postgresql-client && rm -rf /var/lib/apt/lists/*

# Copy Superset config
COPY --chown=superset:superset superset_config.py /app/pythonpath/superset_config.py

# Copy entrypoint
COPY --chown=superset:superset entrypoint.sh /app/entrypoint.sh
RUN chmod 755 /app/entrypoint.sh

# Use entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]

# Expose Superset port
EXPOSE 8088

# Default CMD (Gunicorn started in entrypoint.sh)
CMD ["superset", "run"]