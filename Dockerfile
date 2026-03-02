FROM apache/superset:latest

USER root

# Install dependencies
RUN python3 -m venv /app/.venv || true
RUN /app/.venv/bin/pip install --upgrade pip
RUN /app/.venv/bin/pip install \
    psycopg2-binary \
    redis \
    gevent>=22.10.2

# Copy config
COPY superset_config.py /app/pythonpath/superset_config.py

ENV SUPERSET_CONFIG_PATH=/app/pythonpath/superset_config.py
ENV PYTHONPATH=/app/pythonpath
ENV FLASK_ENV=production

USER superset

# Initialize DB and create guest user
CMD ["/bin/bash", "-c", "\
    superset db upgrade && \
    superset init && \
    superset fab create-user \
        --username guest \
        --firstname Guest \
        --lastname User \
        --email guest@example.com \
        --password guest \
        --role Gamma || true && \
    gunicorn -w 2 -k gevent -b 0.0.0.0:$PORT 'superset.app:create_app()' \
"]