$ = require('jquery')
template = require('./template')

class WordsPanel
  constructor: ->
    @el = $('<div>')
    @el.html template()

module.exports = WordsPanel
