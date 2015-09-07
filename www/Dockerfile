FROM iojs:2

MAINTAINER Clay Miller "clay@smockle.com"

# Create directories on container
RUN mkdir -p /usr/local/src/react /var/www/react /tmp
WORKDIR /usr/local/src/react

# Install node modules
COPY app/package.json /tmp/package.json
RUN cd /tmp && npm i
RUN cp -a /tmp/node_modules .

# Copy source from host to container
COPY app .

# Build source
RUN ./node_modules/.bin/react build && \
    cp -af dist/* /var/www/static

# VOLUME ["/var/www/static"]
