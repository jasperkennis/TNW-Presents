http = require('http')
mu = require('mu2')

mu.root = "#{ __dirname }/templates"
mu.compileAndRender 'index.html',
  name: "john"
.on 'data', (data) ->
  console.log data.toString()

http.createServer (request, response ) ->
  response.writeHead 200,
    "Content-Type": "text/plain"
  response.write "Hello World!"
  response.end()
.listen(8888)
