FROM apache/superset:latest

USER root

# Install required dependencies (including gevent)
RUN pip install --no-cache-dir \
    psycopg2-binary \
    redis \
    gevent>=21.1.2 \
    flask-limiter>=2.9.0 \
    pandas>=2.0.3 \
    numpy>=1.25.0

USER superset

# Initialize Superset and start server
CMD superset db upgrade && \
    superset fab create-admin \
    --username admin \
    --firstname Admin \
    --lastname User \
    --email admin@example.com \
    --password admin && \
    superset init && \
    superset run -h 0.0.0.0 -p 8088