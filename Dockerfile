FROM nodered/node-red:latest

# Copy pre-built flows into Node-RED user data dir
COPY data /data

# Permissions
RUN chown -R node-red:node-red /data

USER node-red
