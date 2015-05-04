// # Ghost Configuration
// Setup your Ghost install for various environments
// Documentation can be found at http://support.ghost.org/config/

var path = require("path"),
    config;

config = {
    // ### Production
    // When running Ghost in the wild, use the production environment
    // Configure your URL and mail settings here
    production: {
        url: "https://blog.smockle.com",

        mail: {
            from: process.env.SES_FROM_ADDRESS,
            transport: "SMTP",
            host: process.env.SES_HOST,
            options: {
              service: "SES",
              from: process.env.SES_FROM_ADDRESS,
              host: process.env.SES_HOST,
              auth: {
                user: process.env.SES_ACCESS_ID,
                pass: process.env.SES_ACCESS_SECRET
              }
            }
        },

        database: {
            client: "postgres",
            connection: {
                host: process.env.POSTGRES_HOST,
                user: process.env.POSTGRES_USER,
                password: process.env.POSTGRES_PASS,
                database: process.env.POSTGRES_DB,
                port: process.env.POSTGRES_PORT
            }
        },

        server: {
            // Host to be passed to node's `net.Server#listen()`
            host: "0.0.0.0",
            // Port to be passed to node's `net.Server#listen()`, for iisnode set this to `process.env.PORT`
            port: "2368"
        },

        storage: {
            active: "ghost-s3",
            "ghost-s3": {
                accessKeyId: process.env.S3_ACCESS_ID,
                secretAccessKey: process.env.S3_ACCESS_SECRET,
                bucket: process.env.S3_BUCKET_NAME,
                region: process.env.S3_BUCKET_REGION,
                assetHost: process.env.S3_HOST
            }
        }
    },

    // ### Development **(default)**
    development: {
        // The url to use when providing links to the site, E.g. in RSS and email.
        // Change this to your Ghost blogs published URL.
        url: "https://blog.smockle.local",

        mail: {
            from: process.env.SES_FROM_ADDRESS,
            transport: "SMTP",
            host: process.env.SES_HOST,
            options: {
              service: "SES",
              from: process.env.SES_FROM_ADDRESS,
              host: process.env.SES_HOST,
              auth: {
                user: process.env.SES_ACCESS_ID,
                pass: process.env.SES_ACCESS_SECRET
              }
            }
        },

        database: {
            client: "postgres",
            connection: {
                host: process.env.POSTGRES_HOST,
                user: process.env.POSTGRES_USER,
                password: process.env.POSTGRES_PASS,
                database: process.env.POSTGRES_DB,
                port: process.env.POSTGRES_PORT
            }
        },

        server: {
            // Host to be passed to node's `net.Server#listen()`
            host: "0.0.0.0",
            // Port to be passed to node's `net.Server#listen()`, for iisnode set this to `process.env.PORT`
            port: "2368"
        },

        paths: {
            contentPath: path.join(process.env.GHOST_CONTENT, "/")
        },

        storage: {
            active: "ghost-s3",
            "ghost-s3": {
                accessKeyId: process.env.S3_ACCESS_ID,
                secretAccessKey: process.env.S3_ACCESS_SECRET,
                bucket: process.env.S3_BUCKET_NAME,
                region: process.env.S3_BUCKET_REGION,
                assetHost: process.env.S3_HOST
            }
        }
    },

    // **Developers only need to edit below here**

    // ### Testing
    // Used when developing Ghost to run tests and check the health of Ghost
    // Uses a different port number
    testing: {
        url: "http://0.0.0.0:2369",
        database: {
            client: "sqlite3",
            connection: {
                filename: path.join(process.env.GHOST_CONTENT, "/data/ghost-test.db")
            }
        },
        server: {
            host: "0.0.0.0",
            port: "2369"
        },
        logging: false
    },

    // ### Testing MySQL
    // Used by Travis - Automated testing run through GitHub
    "testing-mysql": {
        url: "http://0.0.0.0:2369",
        database: {
            client: "mysql",
            connection: {
                host     : "0.0.0.0",
                user     : "root",
                password : "",
                database : "ghost_testing",
                charset  : "utf8"
            }
        },
        server: {
            host: "0.0.0.0",
            port: "2369"
        },
        logging: false
    },

    // ### Testing pg
    // Used by Travis - Automated testing run through GitHub
    "testing-pg": {
        url: "http://0.0.0.0:2369",
        database: {
            client: "pg",
            connection: {
                host     : "0.0.0.0",
                user     : "postgres",
                password : "",
                database : "ghost_testing",
                charset  : "utf8"
            }
        },
        server: {
            host: "0.0.0.0",
            port: "2369"
        },
        logging: false
    }
};

// Export config
module.exports = config;
