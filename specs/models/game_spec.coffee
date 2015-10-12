require('../spec_helper')

Game = require('../../src/models/game')
Word = require('../../src/models/word')

describe 'Game', ->
  beforeEach ->
    @game = new Game()

  describe '#constructor', ->
    it 'should set up the appropriate state', ->
      expect(@game.get('words')).toEqual([])
      expect(@game.get('board').length).toEqual(4)
      expect(@game.get('board')[0].length).toEqual(4)

  describe '#isInGame', ->
    it 'should be true when less than #duration since start', ->
      start = @game.get('start')
      time = new Date(start.getTime() + 60*1000 - 1)

      expect(@game.isInGame(time)).toBeTruthy()

    it 'should be false when #duration since start', ->
      start = @game.get('start')
      time = new Date(start.getTime() + 60*1000)

      expect(@game.isInGame(time)).toBeFalsy()

    it 'should be false when more than #duration since start', ->
      start = @game.get('start')
      time = new Date(start.getTime() + 60*1000 + 1)

      expect(@game.isInGame(time)).toBeFalsy()

  describe '#timeLeft', ->
    it 'should return the amount of time left', ->
      start = @game.get('start')
      time = new Date(start.getTime() + 1)

      expect(@game.timeLeft(time)).toEqual(60*1000 - 1)

  describe '#points', ->
    it 'should return zero if game has no words', ->
      @game.set('words', [])

      expect(@game.points()).toEqual(0)

    it 'should return points of word if game has one word', ->
      @game.set('words', [new Word(literal: 'foo')])

      expect(@game.points()).toEqual(3)

    it 'should return sum of points of word if game has multiple words', ->
      @game.set('words', [new Word(literal: 'foo'), new Word(literal: 'ba')])

      expect(@game.points()).toEqual(5)

  describe '#wordPath', ->
    beforeEach ->
      @game.set('board', [['a', 'b'], ['c', 'd']])

    it 'should return undefined if word isn\'t present', ->
      word = new Word(literal: 'x')
      expect(@game.wordPath(word)).toEqual(undefined)

    it 'should return undefined if a word would reuse letters', ->
      word = new Word(literal: 'aba')
      expect(@game.wordPath(word)).toEqual(undefined)

    it 'should return the path for a word that goes up', ->
      word = new Word(literal: 'ca')
      expect(@game.wordPath(word)).toEqual([[1,0],[0,0]])

    it 'should return the path for a word that goes up, right', ->
      word = new Word(literal: 'da')
      expect(@game.wordPath(word)).toEqual([[1,1],[0,0]])

    it 'should return the path for a word that goes right', ->
      word = new Word(literal: 'ab')
      expect(@game.wordPath(word)).toEqual([[0,0],[0,1]])

    it 'should return the path for a word that goes down, right', ->
      word = new Word(literal: 'ad')
      expect(@game.wordPath(word)).toEqual([[0,0],[1,1]])

    it 'should return the path for a word that goes down', ->
      word = new Word(literal: 'ac')
      expect(@game.wordPath(word)).toEqual([[0,0],[1,0]])

    it 'should return the path for a word that goes down, left', ->
      word = new Word(literal: 'bc')
      expect(@game.wordPath(word)).toEqual([[0,1],[1,0]])

    it 'should return the path for a word that goes left', ->
      word = new Word(literal: 'ba')
      expect(@game.wordPath(word)).toEqual([[0,1],[0,0]])

    it 'should return the path for a word that up, left', ->
      word = new Word(literal: 'da')
      expect(@game.wordPath(word)).toEqual([[1,1],[0,0]])

  describe '#isWordPresent', ->
    beforeEach ->
      @game.set('board', [['a', 'b'], ['c', 'd']])

    it 'should be false if word isn\'t present', ->
      word = new Word(literal: 'x')
      expect(@game.isWordPresent(word)).toEqual(false)

    it 'should be false if a word would reuse letters', ->
      word = new Word(literal: 'aba')
      expect(@game.isWordPresent(word)).toEqual(false)

    it 'should be truth if the word is present', ->
      word = new Word(literal: 'ab')
      expect(@game.isWordPresent(word)).toEqual(true)

  describe '#isWordUnique', ->
    beforeEach ->

    it 'should be false if word is already present', ->
      @game.set('words', [new Word(literal: 'x')])
      word = new Word(literal: 'x')
      expect(@game.isWordUnique(word)).toEqual(false)

    it 'should be true if Game#words is empty', ->
      @game.set('words', [])
      word = new Word(literal: 'x')
      expect(@game.isWordUnique(word)).toEqual(true)

    it 'should be true if Game#words has a different word in it', ->
      @game.set('words', [new Word(literal: 'y')])
      word = new Word(literal: 'x')
      expect(@game.isWordUnique(word)).toEqual(true)
