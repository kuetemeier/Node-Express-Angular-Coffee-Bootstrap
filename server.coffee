"use strict"

###
  Requires
###
express        = require 'express'
assets         = require 'connect-assets'
path           = require 'path'
http           = require 'http'
coffee         = require 'coffee-script'
routes         = require './server/routes'
user           = require './server/routes/user'
passport       = require 'passport'
passportLocal  = require 'passport-local'
LocalStrategy  = passportLocal.Strategy
connect_flash  = require 'connect-flash'

config         = require './server/config/server-config'
errorHandler   = require './server/src/errorHandler'


###
  passport authentication - part I
###

user_guest = { id: -1, username: 'Guest', password: '', email: ''}

users = [
  { id: 1, username: 'bob', password: 'secret', email: 'bob@example.com' }
, { id: 2, username: 'joe', password: 'birthday', email: 'joe@example.com' }
]

findById = (id, fn) ->
  idx = id - 1
  if (users[idx])
    fn(null, users[idx])
  else
    fn(new Error('User ' + id + ' does not exist'))

findByUsername = (username, fn) ->
  for i in [0..(users.length - 1)]
    user = users[i]
    if (user.username == username)
      return fn(null, user)
  return fn(null, null);

###
  Passport session setup.
  To support persistent login sessions, Passport needs to be able to
  serialize users into and deserialize users out of the session.  Typically,
  this will be as simple as storing the user ID when serializing, and finding
  the user by ID when deserializing.
###
passport.serializeUser ( (user, done) ->
  done(null, user.id)
)

passport.deserializeUser ( (id, done) ->
  findById(id, (err, user) ->
    done(err, user)
  )
)


###
  Use the LocalStrategy within Passport.
  Strategies in passport require a verify function, which accept
  credentials (in this case, a username and password), and invoke a callback
  with a user object.  In the real world, this would query a database;
  however, in this example we are using a baked-in set of users.
###
passport.use(new LocalStrategy(
  (username, password, done) ->
    # asynchronous verification, for effect...
    process.nextTick(() ->

      # Find the user by username.  If there is no user with the given
      # username, or the password is not correct, set the user to "false" to
      # indicate failure and set a flash message.  Otherwise, return the
      # authenticated  "user".
      findByUsername(username, (err, user) ->
        if (err)
          return done(err)
        if (!user)
          return done(null, false, { message: 'Unknown user ' + username })
        if (user.password != password)
          return done(null, false, { message: 'Invalid password' })
        done(null, user)
      )
    )
))

###
  Declare & Configure the Server
###
server  = module.exports = express()

localsHelper = -> (req, res, next) ->
  if (req.isAuthenticated())
    user = req.user
  else
    user = user_guest

  user.isAuthenticated = req.isAuthenticated()
  res.locals({ user: user })

  language = req.session.language || "en"
  res.locals ({ 'language': language })

  res.locals ({ 'i18': (clause) ->
    translate(clause, language)
  })

  next()


###
  'static' locals
###
server.locals({
  config:   config
  title:    'Node Express Angular Coffee Bootstrap - Template'
  author:   'Joerg Kuetemeier (jkuetemeier@kuetemeier.net)'
})

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
  server.use connect_flash()

  server.use passport.initialize()
  server.use passport.session()
  server.use localsHelper()

  server.use errorHandler.notFound404
  server.use errorHandler.logError
  server.use errorHandler.xhrError
  server.use errorHandler.defaultError

  ###
    # enable this if you have styl css files in your public folder
    server.use(require('stylus').middleware(path.join(__dirname, 'client', '/public')))
  ###
  server.use express.static(path.join(__dirname, 'client', 'public'))

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
server.get '/view1', (req, res) ->
  res.render 'index'

server.get '/view2', (req, res) ->
  res.render 'index' 

server.get '/ng-grid', (req, res) ->
  res.render 'index' 


###
  authentication stuff
###

server.get '/login', (req, res) ->
  res.render 'login', { message: req.flash('error') }

server.post '/login',
  passport.authenticate('local', { failureRedirect: '/login', failureFlash: true }), (req, res) ->
    res.redirect '/'

server.get '/logout', (req, res) ->
  req.logout()
  res.redirect '/'

###
 Simple route middleware to ensure user is authenticated.
 Use this route middleware on any resource that needs to be protected.  If
 the request is authenticated (typically via a persistent login session),
 the request will proceed.  Otherwise, the user will be redirected to the
 login page.
###
ensureAuthenticated = (req, res, next) ->
  if (res.locals.user.isAuthenticated)
    return next()
  res.redirect('/login')


server.get '/account', ensureAuthenticated, (req, res) ->
  res.render 'account', {}



###
  Startup and log.
###
http.createServer(server).listen server.get('port'), ->
  console.log "Express server listening on port #{server.get('port')}"
