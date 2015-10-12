Model = require './model'

class Game extends Model
  duration: 60*1000
  size: 4

  constructor: ->
    super

    @set('start', new Date())
    @initBoard()
    @initWordList()
    @initTicker()

  destroy: ->
    clearInterval @ticker

  initBoard: ->
    board = for i in [0...@size]
      for j in [0...@size]
        @_randomLetter()

    @set('board', board)

  initWordList: ->
    @set('wordList', [])

  initTicker: =>
    times = 0
    tickerFunc = =>
      if !@isInGame(new Date())
        clearInterval @ticker
      @trigger('tick')

    @ticker = setInterval tickerFunc, 300
  
  isInGame: (time)->
    @timeLeft(time) > 0

  timeLeft: (time)->
    (@get('start') - time) + @duration
  
  points: ->
    points = _.reduce @get('words'), (sum, w)-> sum + w.value()
    points or 0

  wordPath: (word)->
    literal = word.get('literal')
    board = @get('board')

    @_wordPath(literal, board)

  isWordPresent: (word)->
    @wordPath(word)?

  isWordUnique: (word)->
    _(@get('words')).all (w)->
      w.get('literal') isnt word.get('literal')

  _randomLetter: ->
    possibles = 'abcdefghijklmnopqrstuvwxyz'
    console.log JSON.stringify possibles
    idx = Math.floor(Math.random() * possibles.length)
    possibles[idx]

  _wordPath: (word, board)->
    for row, i in board
      for char, j in row
        path = @_tryStart(word, board, [i,j], {})
        return path if path
    undefined

  _pathFrom: (word, board, start, visited = {})->
    return [start] unless word.length > 1
    word = word.slice(1)

    [i, j] = start
    visited[i] ?= {}
    visited[i][j] = true

    directions = for k in [-1..1]
      for l in [-1..1]
        [i + k, j + l]
    directions = _(directions).flatten().value()

    for d in directions
      path = @_tryStart(word, board, d, visited)
      return [[i,j]].concat path if path
    undefined

  _tryStart: (word, board, start, visited)->
    firstChar = word[0]
    [i, j] = start
    if !visited[i]?[j] and board[i]?[j] is firstChar
      @_pathFrom(word, board, [i,j], visited)

window.Game = Game
module.exports = Game
