$ = require('jquery')
template = require('./template')

Component = require('../component')
Game = require('../../models/game')
Word = require('../../models/word')

class ControlPanel extends Component
  template: template

  constructor: (opts)->
    super
    @state = opts.state

    @state.on 'all', @render
    @state.on 'change:game:end', @endGame
    @el.on 'click', '.start-button', @startGame
    @el.on 'click', '.quit-button', @quitGame
    @el.on 'click', '.replay-button', @replayGame

    @render()

  data: ->
    game = @state.get('game')
    time = new Date()

    timeLeft: Math.floor(game?.timeLeft(time) / 1000)
    points: game?.points()
    isPreGame: !game?
    isInGame: game? && game.isInGame(time)
    isPostGame: game? && !game.isInGame(time)

  # DOM -> State
  startGame: =>
    @state.set('game', new Game())

  quitGame: =>
    @state.get('game').destroy()
    @state.set('currentWord', new Word(literal: ''))
    @state.set('game', undefined)

  replayGame: =>
    @state.get('game').destroy()
    @state.set('currentWord', new Word(literal: ''))
    @state.set('game', new Game())

  endGame: =>
    @state.set('currentWord', new Word(literal: ''))

module.exports = ControlPanel
