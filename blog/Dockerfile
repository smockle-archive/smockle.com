FROM ghost

MAINTAINER Clay Miller "clay@smockle.com"

# Install node modules
ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN mkdir -p /usr/src/ghost && cp -a /tmp/node_modules /usr/src/ghost

# Copy custom configuration from the current directory
ADD config.js /var/lib/ghost/config.js

# Use S3 as a storage provider
ADD storage/ghost-s3/index.js /usr/src/ghost/content/storage/ghost-s3/
