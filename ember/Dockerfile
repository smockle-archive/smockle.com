FROM iojs:2

MAINTAINER Clay Miller "clay@smockle.com"

# Create directories on container
RUN mkdir -p /usr/local/src/ember /var/www/ember /tmp
WORKDIR /usr/local/src/ember

# Install node modules
COPY app/package.json /tmp/package.json
RUN cd /tmp && npm i
RUN cp -a /tmp/node_modules .

# Copy source from host to container
COPY app .

# Build source
RUN ./node_modules/.bin/ember build && \
    cp -af dist/* /var/www/static

VOLUME ["/var/www/static"]
