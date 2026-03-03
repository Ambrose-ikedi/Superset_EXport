FROM apache/superset:latest

USER root

# Install postgres driver INSIDE Superset venv
RUN /app/.venv/bin/pip install psycopg2-binary

USER superset

WORKDIR /app

COPY --chown=superset:superset superset_config.py /app/pythonpath/superset_config.py
COPY --chown=superset:superset entrypoint.sh /app/entrypoint.sh
COPY --chown=superset:superset superset_export /app/superset_export

RUN chmod +x /app/entrypoint.sh

CMD ["/app/entrypoint.sh"]