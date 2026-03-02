FROM apache/superset:latest

WORKDIR /app

# Copy config and entrypoint
COPY --chown=superset:superset superset_config.py /app/pythonpath/superset_config.py
COPY --chown=superset:superset entrypoint.sh /app/entrypoint.sh

# Make entrypoint executable
RUN chmod 755 /app/entrypoint.sh

EXPOSE 8088

ENTRYPOINT ["/app/entrypoint.sh"]