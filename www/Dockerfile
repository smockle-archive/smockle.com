FROM node:4.1.1

MAINTAINER Clay Miller "clay@smockle.com"

# Create directories on container
RUN mkdir -p /usr/local/src/www /var/www/static /tmp
WORKDIR /usr/local/src/www

# Update to npm 3.3.5
RUN npm i -g npm@3.3.5

# Install node modules
ADD app/package.json /tmp/package.json
RUN cd /tmp && npm i
RUN cp -a /tmp/node_modules .

# Copy source from host to container
ADD app .

# Build source
RUN NODE_ENV=production ./node_modules/.bin/babel-node ./node_modules/.bin/webpack && \
    cp -af dist/* /var/www/static

VOLUME /var/www/static
