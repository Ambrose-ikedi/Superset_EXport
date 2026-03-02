# Use the official Apache Superset image
FROM apache/superset:latest

# Set workdir
WORKDIR /app

# Copy Superset config and entrypoint
COPY superset_config.py /app/pythonpath/superset_config.py
COPY entrypoint.sh /app/entrypoint.sh

# Make entrypoint executable
RUN chmod +x /app/entrypoint.sh

# Expose the port (Render uses $PORT)
EXPOSE 8088

# Use our entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]