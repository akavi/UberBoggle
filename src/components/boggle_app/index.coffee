$ = require('jquery')
template = require('./template')

Board = require('../board')
ControlPanel = require('../control_panel')
WordsPanel = require('../words_panel')

class BoggleApp
  constructor: ->
    @el = $('<div>')
    @el.html template()

    board = new Board()
    @el.find('.h-board').html board.el

    controlPanel = new ControlPanel()
    @el.find('.h-control-panel').html controlPanel.el

    wordsPanel = new WordsPanel()
    @el.find('.h-words-panel').html wordsPanel.el

module.exports = BoggleApp
