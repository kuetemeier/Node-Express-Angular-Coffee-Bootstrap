"use strict"

###
  Requires
###
express      = require 'express'
assets       = require 'connect-assets'
path         = require 'path'
http         = require 'http'
coffee       = require 'coffee-script'
routes       = require './server/routes'
user         = require './server/routes/user'

config       = require './server/config/server-config'
errorHandler = require './server/src/errorHandler'


###
  Declare & Configure the Server
###
server  = module.exports = express()

server.configure ->
  server.set 'port', process.env.PORT or config.port
  server.set 'views', path.join(__dirname, 'server', '/views')
  server.set 'view engine', 'jade'
  server.set 'view options', { layout: false, pretty: false }
  server.use express.favicon()
  server.use express.logger('dev')
  server.use express.bodyParser()
  server.use express.methodOverride()
  server.use assets({src: path.join(__dirname, 'client', 'src')})
  server.use express.cookieParser(config.cookieSecret)
  server.use express.session()

  server.use errorHandler.notFound404
  server.use errorHandler.logError
  server.use errorHandler.xhrError
  server.use errorHandler.defaultError

  ###
    # enable this if you have styl css files in your public folder
    server.use(require('stylus').middleware(path.join(__dirname, 'client', '/public')))
  ###
  server.use express.static(path.join(__dirname, 'client', 'public'))

  ###
    server.use (req, res) ->
      language = req.session.language || "en"
      res.locals.language = language
      res.locals.title = "Huhu"
      res.locals.translate = (clause) ->
        translate(clause, language)
  ###

  server.locals({
    title: 'Test Locals'
  })

  server.use server.router

  server.use (req, res, next) ->
    res.status(404)

    # respond with html page
    if (req.accepts('html'))
      res.render('404-not-found', { url: req.url })
    else
      # respond with json
      if (req.accepts('json'))
        res.send({ error: 'Not found' })
      else
        # default to plain-text. send()
        res.type('txt').send('Not found')

###
  specific server config for development environment
###
server.configure 'development', () ->
  console.log 'server running in development mode'
  server.use express.errorHandler( { dumpExceptions: true, showStack: true } )

###
  specific server config for production environment
###
server.configure 'production', () ->
  console.log 'server running in production mode'
  server.use express.errorHandler()

###
  server.dynamicHelpers({
    session: (req, res) ->
      req.session
    ,title: "test"
    ,language : (req, res) ->
      req.session.language || "en"
  })
###


###
  Define routes
###
server.get '/', (req, res) ->
  routes.index req, res

server.get '/error', (req, res) ->
  throw "Error - Fehler"

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
