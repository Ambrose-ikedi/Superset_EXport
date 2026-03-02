# Use the official Apache Superset image as base
FROM apache/superset:latest

# Set working directory
WORKDIR /app

# Copy configuration and entrypoint
COPY --chown=superset:superset superset_config.py /app/pythonpath/superset_config.py
COPY --chown=superset:superset entrypoint.sh /app/entrypoint.sh

# Make entrypoint executable
RUN chmod 755 /app/entrypoint.sh

# Expose the port Render uses
ENV PORT=8088
EXPOSE $PORT

# Set entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]