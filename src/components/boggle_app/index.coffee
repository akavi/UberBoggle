$ = require('jquery')

template = require('./template')

Component = require('../component')
BoardComponent = require('../board')
ControlPanelComponent = require('../control_panel')
WordsPanelComponent = require('../words_panel')

Model = require('../../models/model')
Game = require('../../models/game')
Word = require('../../models/word')
Board = require('../../models/word')

class BoggleApp extends Component
  template: template

  constructor: ->
    super

    @state = new Model()
    @state.set('game', undefined)
    @state.set('currentWord', new Word(literal: ''))
    @state.set('activeWord', undefined)

    @render()

  render: =>
    super

    @board ?= new BoardComponent(state: @state)
    @$('.h-board').html @board.el

    @controlPanel ?= new ControlPanelComponent(state: @state)
    @$('.h-control-panel').html @controlPanel.el

    @wordsPanel ?= new WordsPanelComponent(state: @state)
    @$('.h-words-panel').html @wordsPanel.el

module.exports = BoggleApp
