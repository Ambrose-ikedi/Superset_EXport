# Use the official Apache Superset image
FROM apache/superset:latest

# Set workdir
WORKDIR /app

# Copy Superset config and entrypoint
# Make entrypoint executable in the COPY command
COPY --chmod=755 superset_config.py /app/pythonpath/superset_config.py
COPY --chmod=755 entrypoint.sh /app/entrypoint.sh

# Expose the port (Render uses $PORT)
EXPOSE 8088

# Use our entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]