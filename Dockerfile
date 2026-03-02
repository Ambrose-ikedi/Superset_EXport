FROM apache/superset:latest

USER root

# Create virtualenv
RUN python3 -m venv /app/.venv || true

# Install Python dependencies inside the virtualenv
RUN /app/.venv/bin/pip install --no-cache-dir \
    psycopg2-binary \
    redis \
    gevent>=23.9.0

# Copy your Superset config
COPY superset_config.py /app/pythonpath/superset_config.py

# Set environment variables
ENV SUPERSET_CONFIG_PATH=/app/pythonpath/superset_config.py
ENV PYTHONPATH=/app/pythonpath

USER superset

# Start Superset
CMD ["/bin/bash", "-c", "\
superset db upgrade && \
superset fab create-admin \
--username ${ADMIN_USER_KEY} \
--firstname ${ADMIN_FIRSTNAME_KEY} \
--lastname ${ADMIN_LASTNAME_KEY} \
--email ${ADMIN_EMAIL_KEY} \
--password ${ADMIN_PASSWORD_KEY} || true && \
superset init && \
/app/.venv/bin/gunicorn -w 2 -k gevent -b 0.0.0.0:$PORT 'superset.app:create_app()' \
"]