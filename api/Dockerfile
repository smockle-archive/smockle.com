FROM iojs:2-onbuild

MAINTAINER Clay Miller "clay@smockle.com"

# Create directories on container
RUN mkdir -p /var/www/api /tmp
WORKDIR /var/www/api

# Install node modules
COPY app/package.json /tmp/package.json
RUN cd /tmp && npm i
RUN cp -a /tmp/node_modules .

# Copy app from host to container
COPY app/* .

# Start the app
EXPOSE 3000
CMD ["node", "--harmony_arrow_functions", "index.js"]
