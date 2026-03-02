FROM apache/superset:latest

USER root

# Install packages inside Superset virtualenv
RUN /app/.venv/bin/pip install --no-cache-dir \
    psycopg2-binary \
    redis \
    gevent>=21.1.2 \
    flask-limiter>=2.9.0 \
    pandas>=2.0.3 \
    numpy>=1.25.0

# Copy config
COPY superset_config.py /app/pythonpath/superset_config.py

# Copy entrypoint
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENV SUPERSET_CONFIG_PATH=/app/pythonpath/superset_config.py
ENV PYTHONPATH=/app/pythonpath

USER superset

ENTRYPOINT ["/app/entrypoint.sh"]