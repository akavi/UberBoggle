$ = require('jquery')
template = require('./template')

class ControlPanel
  constructor: ->
    @el = $('<div>')
    @el.html template()

module.exports = ControlPanel
