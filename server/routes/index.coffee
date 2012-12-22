
###
  GET home page.
###

exports.index = (req, res) ->
  res.render 'index', { title: 'Node Express Angular Coffee Bootstrap - Template', user: req.user }
