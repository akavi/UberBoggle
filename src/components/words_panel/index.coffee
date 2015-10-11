$ = require('jquery')
template = require('./template')

class WordsPanel
  constructor: (opts)->
    @el = $('<div>')
    @state = opts.state

    @state.on 'all', @render
    @render()

  render: =>
    @el.html template(@data())

  data: ->
    game = @state.get('game')
    words = game?.get('words') || []
    currentWord = @state.get('currentWord')

    checkable = currentWord?.get('literal').length > 0
    currentPoints = currentWord?.get('value')
    isChecking = !currentWord?.get('real')?
    isReal = currentWord?.get('real') is true
    isUnique = game?.isWordUnique(currentWord)
    isOnBoard = game?.isWordPresent(currentWord)

    words: words.map (w)->
      {literal: w.get('literal'), value: w.value()}
    currentWord: currentWord.get('literal')
    currentPoints:
      checkable && !isntReal && !isntUnique && !isntOnBoard && currentPoints
    isChecking: checkable and isChecking
    isntReal: checkable and !isReal
    isntOnBoard: checkable and isReal and !isOnBoard
    isntUnique: checkable and isReal and !isUnique

module.exports = WordsPanel
