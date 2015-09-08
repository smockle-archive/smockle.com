FROM ghost:0

MAINTAINER Clay Miller "clay@smockle.com"

# Create directories on container
RUN mkdir -p /usr/src/ghost /tmp
WORKDIR /usr/src/ghost

# Install node modules
COPY app/package.json /tmp/package.json
RUN cd /tmp && npm i
RUN cp -a /tmp/node_modules .

# Copy custom configuration from the current directory
COPY app/config.js /var/lib/ghost/config.js

# Use S3 as a storage provider
COPY app/storage.js content/storage/ghost-s3/index.js
