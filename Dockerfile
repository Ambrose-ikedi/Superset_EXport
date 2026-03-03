FROM apache/superset:latest

USER root

# Install Postgres driver
RUN pip install psycopg2-binary

WORKDIR /app

COPY superset_config.py /app/pythonpath/superset_config.py
COPY entrypoint.sh /app/entrypoint.sh
COPY superset_export /app/superset_export

RUN chmod +x /app/entrypoint.sh

USER superset

CMD ["/app/entrypoint.sh"]