FROM apache/superset:latest

USER root

# Install postgres driver
RUN pip install psycopg2-binary

USER superset

WORKDIR /app

COPY --chown=superset:superset superset_config.py /app/pythonpath/superset_config.py
COPY --chown=superset:superset entrypoint.sh /app/entrypoint.sh

RUN chmod +x /app/entrypoint.sh

CMD ["/app/entrypoint.sh"]