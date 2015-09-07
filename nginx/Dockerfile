FROM nginx:1

MAINTAINER Clay Miller "clay@smockle.com"

WORKDIR /etc/nginx

# Copy server configuration
COPY nginx.conf nginx.conf

# Transform and link site configuration templates
# COPY build.sh build.sh
# COPY server/sites-template ./sites-template
# RUN chmod +x build.sh; sync; ./build.sh

# Copy site configurations
COPY server/sites-available ./sites-available
COPY server/sites-enabled ./sites-enabled

# Copy certificates
COPY server/ssl ./ssl
