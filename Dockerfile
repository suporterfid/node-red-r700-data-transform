# Use official Node-RED image as base
FROM nodered/node-red:latest

# Switch to root to install packages
USER root

# Install any additional nodes if needed
# RUN npm install node-red-contrib-*

# Copy flows
COPY data/flows.json /data/flows.json

# Set ownership to node-red user
RUN chown -R node-red:node-red /data

# Switch back to node-red user
USER node-red

# Expose Node-RED port
EXPOSE 1880

# Start Node-RED
CMD ["node-red"]
