FROM apache/superset:latest

WORKDIR /app

# Install OS deps
USER root
RUN apt-get update && apt-get install -y \
    postgresql-client \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python Postgres driver
USER superset
RUN pip install --no-cache-dir psycopg2-binary

# Copy Superset config and entrypoint
COPY --chown=superset:superset superset_config.py /app/pythonpath/superset_config.py
COPY --chown=superset:superset entrypoint.sh /app/entrypoint.sh
RUN chmod 755 /app/entrypoint.sh

# Entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]

# Expose port
EXPOSE 8088

# Default CMD
CMD ["superset", "run"]