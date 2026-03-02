FROM apache/superset:latest

USER root

RUN python3 -m venv /app/.venv || true
RUN /app/.venv/bin/pip install psycopg2-binary redis gevent

COPY superset_config.py /app/pythonpath/superset_config.py

ENV SUPERSET_CONFIG_PATH=/app/pythonpath/superset_config.py
ENV PYTHONPATH=/app/pythonpath

USER superset

CMD ["/bin/bash", "-c", "\
# Upgrade DB \
superset db upgrade && \
# Create admin \
superset fab create-admin \
--username ${ADMIN_USER_KEY} \
--firstname ${ADMIN_FIRSTNAME_KEY} \
--lastname ${ADMIN_LASTNAME_KEY} \
--email ${ADMIN_EMAIL_KEY} \
--password ${ADMIN_PASSWORD_KEY} || true && \
# Initialize Superset \
superset init && \
# Create public role & user for embedding dashboards \
superset fab create-role --role-name 'Public' || true && \
superset fab create-user \
--username ${PUBLIC_USER_USERNAME} \
--firstname 'Guest' \
--lastname 'User' \
--email ${PUBLIC_USER_EMAIL} \
--role 'Public' \
--password 'public_password' || true && \
# Start Gunicorn \
gunicorn -w 2 -k gevent -b 0.0.0.0:$PORT 'superset.app:create_app()' \
"]