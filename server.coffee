###
	Requires
###
express = require 'express'
assets	= require 'connect-assets'
path	= require 'path'
http	= require 'http'
coffee	= require 'coffee-script'

config	= require './config'

###
	Declare & Configure the Server
###
server	= express()

server.configure ->
	server.set "port", process.env.PORT or config.port
	server.set "views", __dirname + "/views"
	server.set "view engine", "jade"
	server.use express.favicon()
	server.use express.logger("dev")
	server.use express.bodyParser()
	server.use express.methodOverride()
	server.use assets()
	server.use express.cookieParser(config.cookieSecret)
	server.use express.session()
	server.use server.router
	server.use express.static(path.join(__dirname, "public"))


###
	Define routes
###
server.get "/", (req, res) ->
	res.render "index"

# All partials. This is used by Angular.
server.get "/partials/:name", (req, res) ->
	name = req.params.name
	res.render "partials/" + name

# Views that are direct linkable
server.get ["/view1", "/view2"], (req, res) ->
	res.render "index"

###
	Startup and log.
###
http.createServer(server).listen server.get("port"), ->
	console.log "Express server listening on port " + server.get("port")