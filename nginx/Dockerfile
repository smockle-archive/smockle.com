FROM nginx:1

MAINTAINER Clay Miller "clay@smockle.com"

WORKDIR /etc/nginx

# Copy server configuration
ADD nginx.conf nginx.conf

# Copy site configurations
ADD server/sites-available ./sites-available
ADD server/sites-enabled ./sites-enabled

# Copy certificates
ADD server/ssl ./ssl
