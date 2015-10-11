$ = require('jquery')
template = require('./template')

class Board
  constructor: ->
    @el = $('<div>')
    @el.html template(@data())

  data: ->
    isPreGame: false
    isInGame: false
    isPostGame: true
    board: [
      ['A1', 'A2', 'A3', 'A4']
      ['B1', 'B2', 'B3', 'B4']
      ['C1', 'C2', 'C3', 'C4']
      ['D1', 'D2', 'D3', 'D4']
    ]

    paths: []

module.exports = Board
