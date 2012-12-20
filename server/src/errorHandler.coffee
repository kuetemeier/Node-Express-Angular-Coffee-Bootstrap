'use strict'

defaultError = (err, req, res, next) ->
  res.status 500
  res.render 'error', { error: err }

logError = (err, req, res, next) ->
  console.error err.stack
  next err

xhrError = (err, req, res, next) ->
  if (req.xhr)
    res.send 500, { error: 'Something blew up!' }
  else
    next err

exports.defaultError = defaultError
exports.logError = logError
exports.xhrError = xhrError