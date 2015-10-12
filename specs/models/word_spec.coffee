require('../spec_helper')

Word = require('../../src/models/word')

describe 'Word', ->
  beforeEach ->
    @word = new Word()

  describe '#points', ->
    it 'equals the length of the word', ->
      @word.set('literal', 'foo')
      expect(@word.points()).toEqual(3)
