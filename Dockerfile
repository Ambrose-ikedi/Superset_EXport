FROM apache/superset:latest

USER root

RUN pip install --no-cache-dir \
    psycopg2-binary \
    redis \
    gevent \
    flask-limiter \
    pandas \
    numpy

COPY superset_config.py /app/pythonpath/superset_config.py

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# IMPORTANT — copy dashboards
COPY superset_export /app/superset_export

ENV SUPERSET_CONFIG_PATH=/app/pythonpath/superset_config.py
ENV PYTHONPATH=/app/pythonpath

USER superset

ENTRYPOINT ["/app/entrypoint.sh"]