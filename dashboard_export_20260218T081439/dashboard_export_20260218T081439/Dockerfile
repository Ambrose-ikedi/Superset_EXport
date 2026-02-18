FROM apache/superset:latest

USER root

# Install Postgres and Redis drivers
RUN pip install psycopg2-binary redis

# Copy our custom config
COPY superset_config.py /app/pythonpath/superset_config.py

ENV SUPERSET_CONFIG_PATH=/app/pythonpath/superset_config.py

USER superset

# Start Superset
CMD ["/bin/bash", "-c", "\
    superset db upgrade && \
    superset fab create-admin --username admin --firstname Superset --lastname Admin --email admin@superset.com --password admin || true && \
    superset init && \
    gunicorn -w 2 -k gevent -b 0.0.0.0:$PORT 'superset.app:create_app()' \
"]
