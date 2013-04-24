http = require('http')
util = require('util')
mu = require('mu2')

mu.root = "#{ __dirname }/templates"

# .on 'data', (data) ->
#   console.log data.toString()

http.createServer (request, response ) ->
  if process.env.NODE_ENV is 'DEVELOPMENT'
    mu.clearCache();
  response.writeHead 200,
    "Content-Type": "text/plain"
  stream = mu.compileAndRender('index.html', {name: "john"})
  util.pump(stream, response);
#   response.end()
.listen(8888)
