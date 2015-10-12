_ = require 'lodash'
Model = require './model'
BoggleUtils = require './boggle_utils'

class Game extends Model
  _.assign(@.prototype, BoggleUtils)
  
  duration: 60*1000
  size: 4

  constructor: ->
    super

    @set('start', new Date())
    @initBoard()
    @initWords()
    @initTicker()

  destroy: ->
    clearInterval @ticker

  initBoard: ->
    board = for i in [0...@size]
      for j in [0...@size]
        @_randomLetter()

    @set('board', board)

  initWords: ->
    @set('words', [])

  initTicker: =>
    times = 0
    tickerFunc = =>
      if !@isInGame(new Date())
        @trigger('end')
        clearInterval @ticker
      else
        @trigger('tick')

    @ticker = setInterval tickerFunc, 300
  
  isInGame: (time)->
    @timeLeft(time) > 0

  timeLeft: (time)->
    (@get('start') - time) + @duration
  
  points: ->
    _.reduce(
      @get('words')
      (sum, w)-> sum + w.points()
      0
    )

  wordPath: (word)->
    literal = word.get('literal')
    board = @get('board')

    @_wordPath(literal, board)

  isWordPresent: (word)->
    @wordPath(word)?

  isWordUnique: (word)->
    _(@get('words')).all (w)->
      w.get('literal') isnt word.get('literal')

module.exports = Game
