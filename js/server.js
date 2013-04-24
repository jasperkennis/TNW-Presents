// Generated by CoffeeScript 1.6.2
var http, mu, util;

http = require('http');

util = require('util');

mu = require('mu2');

mu.root = "" + __dirname + "/templates";

http.createServer(function(request, response) {
  var stream;

  response.writeHead(200, {
    "Content-Type": "text/plain"
  });
  stream = mu.compileAndRender('index.html', {
    name: "john"
  });
  return util.pump(stream, response);
}).listen(8888);
