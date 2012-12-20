"use strict"

###
  Requires
###
express = require 'express'
assets  = require 'connect-assets'
path    = require 'path'
http    = require 'http'
coffee  = require 'coffee-script'
routes  = require './server/routes'
user    = require './server/routes/user'

config  = require './server/config/server-config'

###
  Declare & Configure the Server
###
server  = express()

server.configure ->
  server.set 'port', process.env.PORT or config.port
  server.set 'views', path.join(__dirname, 'server', '/views')
  server.set 'view engine', 'jade'
  server.use express.favicon()
  server.use express.logger('dev')
  server.use express.bodyParser()
  server.use express.methodOverride()
  server.use assets({src: path.join(__dirname, 'client', 'src')})
  server.use express.cookieParser(config.cookieSecret)
  server.use express.session()
  server.use server.router
  ###
    # enable this if you have styl css files in your public folder
    server.use(require('stylus').middleware(path.join(__dirname, 'client', '/public')))
  ###
  server.use express.static(path.join(__dirname, 'client', 'public'))


###
  Define routes
###
server.get '/', (req, res) ->
  routes.index req, res

server.get '/users', (req, res) ->
  user.list req, res

# All partials. This is used by Angular.
server.get '/partials/:name', (req, res) ->
  name = req.params.name
  res.render 'partials/' + name

# Views that are direct linkable
server.get ['/view1', '/view2'], (req, res) ->
  res.render 'index'

###
  Startup and log.
###
http.createServer(server).listen server.get('port'), ->
  console.log "Express server listening on port #{server.get('port')}"
