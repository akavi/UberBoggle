Model = require './model'

class Game extends Model
  duration: 60*1000
  size: 4

  constructor: ->
    super
    @initBoard()
    @initWordList()

  initBoard: ->
    board = for i in [0...@size]
      for j in [0...@size]
        @_randomLetter()

    @set('board', board)

  initWordList: ->
    @set('wordList', [])
  
  isInGame: (time)->
    @timeLeft(time) > 0

  timeLeft: (time)->
    @get('start') + @duration - time
  
  points: ->
    _(@get('words')).reduce (sum, w)-> sum + w.value()

  wordPath: (word)->
    literal = word.get('literal')
    board = @get('board')

    @_wordPath(literal, board)

  isWordPresent: (word)->
    @isWordPresent(word)

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
