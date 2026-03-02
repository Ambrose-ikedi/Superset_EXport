FROM apache/superset:latest

USER root

# Install postgres client for pg_isready
RUN apt-get update && apt-get install -y postgresql-client && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --chown=superset:superset superset_config.py /app/pythonpath/superset_config.py
COPY --chown=superset:superset entrypoint.sh /app/entrypoint.sh
RUN chmod 755 /app/entrypoint.sh

USER superset