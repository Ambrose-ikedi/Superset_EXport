FROM apache/superset:latest

USER root

RUN pip install psycopg2-binary redis

COPY superset_config.py /app/pythonpath/superset_config.py

ENV SUPERSET_CONFIG_PATH=/app/pythonpath/superset_config.py
ENV PYTHONPATH=/app/pythonpath

USER superset

CMD ["/bin/bash", "-c", "\
    superset db upgrade && \
    superset fab create-admin \
    --username ${ADMIN_USER_KEY} \
    --firstname ${ADMIN_FIRSTNAME_KEY} \
    --lastname ${ADMIN_LASTNAME_KEY} \
    --email ${ADMIN_EMAIL_KEY} \
    --password ${ADMIN_PASSWORD_KEY} || true && \
    superset init && \
    gunicorn -w 2 -k gevent -b 0.0.0.0:$PORT 'superset.app:create_app()' \
"]