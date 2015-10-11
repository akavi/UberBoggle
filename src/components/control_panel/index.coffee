$ = require('jquery')
template = require('./template')

class ControlPanel
  constructor: (opts)->
    @el = $('<div>')
    @state = opts.state
    
    @state.on 'all', @render
    @el.on 'click', '.start-button', @startGame
    @render()

  render: =>
    @el.html template(@data())

  data: ->
    game = @state.get('game')
    time = new Date()

    data =
      timeLeft: Math.floor(game?.timeLeft(time) / 1000)
      points: game?.points()
      isPreGame: !game?
      isInGame: game? && game.isInGame(time)
      isPostGame: game? && !game.isInGame(time)

    console.log data
    console.log JSON.stringify(data)

    data

  # DOM -> State
  startGame: =>
    console.log 'starting game'
    game = new Game()
    @state.set('game', game)

module.exports = ControlPanel
