FROM apache/superset:latest

USER root

# Install required dependencies
RUN pip install --no-cache-dir \
    psycopg2-binary \
    redis \
    gevent>=21.1.2 \
    flask-limiter>=2.9.0 \
    pandas>=2.0.3 \
    numpy>=1.25.0

USER superset