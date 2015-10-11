$ = require('jquery')
template = require('./template')

class Board
  constructor: ->
    @el = $('<div>')
    @el.html template()

module.exports = Board
