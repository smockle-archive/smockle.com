FROM nginx

MAINTAINER Clay Miller "clay@smockle.com"

# Copy server configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Transform and link site configuration templates
COPY build.sh /etc/nginx/build.sh
COPY sites-template/* /etc/nginx/sites-template/
WORKDIR /etc/nginx
RUN cd /etc/nginx; chmod +x build.sh; sync; ./build.sh

# Copy site configurations
COPY sites-available /etc/nginx/
COPY sites-enabled /etc/nginx/

# Copy certificates
COPY ssl/* /etc/nginx/ssl/
