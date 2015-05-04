FROM iojs:onbuild

MAINTAINER Clay Miller "clay@smockle.com"

# Install node modules
ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN mkdir -p /opt/app && cp -a /tmp/node_modules /opt/app/

# Create and copy to app directory
RUN mkdir -p /opt/app
WORKDIR /opt/app
COPY . /opt/app

# Start the app
EXPOSE 3000
CMD ["node", "--harmony_arrow_functions", "index.js"]
