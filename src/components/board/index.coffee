$ = require('jquery')
template = require('./template')

Component = require('../component')

class Board extends Component
  template: template

  constructor: (opts = {})->
    super
    @state = opts.state

    @state.on 'all', @render
    @render()

  data: ->
    time = new Date()
    game = @state.get('game')
    activeWord = @state.get('activeWord')

    board = game?.get('board')
    board ?= for i in Array(4)
      for i in Array(4)
        undefined

    isPreGame: !game?
    isInGame: game?.isInGame(time)
    isPostGame: game and !game?.isInGame(time)
    board: board
    path: game?.wordPath(activeWord) if activeWord

module.exports = Board
