'use strict'

module.exports = exports =

  notFound404: (err, req, res, next) ->
    res.status 404
    res.render '404-not-found', { error: err }

  defaultError: (err, req, res, next) ->
    res.status 500
    res.render '500-internal-server-error', { error: err }

  logError: (err, req, res, next) ->
    console.error err.stack
    next err

  xhrError: (err, req, res, next) ->
    if (req.xhr)
      res.send 500, { error: 'Something blew up!' }
    else
      next err

