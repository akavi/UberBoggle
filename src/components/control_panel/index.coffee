$ = require('jquery')
template = require('./template')

class ControlPanel
  constructor: ->
    @el = $('<div>')
    @el.html template(@data())

  data: ->
    timeLeft: 50
    points: 40
    isPreGame: true
    isInGame: false
    isPostGame: false

module.exports = ControlPanel
