#!/usr/bin/env node
"use strict";

let express = require("express");
let app = express();

app.get("/", (request, response) => {
  response.send("Hello world!\n");
});

const PORT = 3000;
app.listen(PORT);
console.log("Running on http://localhost:" + PORT);
