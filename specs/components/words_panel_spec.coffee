Helper = require('../spec_helper')
WordsPanel = require('../../src/components/words_panel')
Game = require('../../src/models/game')
Word = require('../../src/models/word')

describe 'WordsPanel', ->
  beforeEach ->
    @state = Helper.makeState()
    @wp = new WordsPanel(state: @state)

  describe 'rendering', ->
    it 'should render correctly initially', ->
      expect(@wp.$('.inactive-word-panel').length > 0).toBeTruthy()
      expect(@wp.$('.word-input-input:disabled').length > 0).toBeTruthy()

    it 'should render correctly when in-game', ->
      @state.set('game', new Game())

      expect(@wp.$('.word-panel').length > 0).toBeTruthy()
      expect(@wp.$('.word-input-input:not(:disabled)').length > 0).toBeTruthy()

    it 'should render correctly when post-game', ->
      @state.set('game', new Game())
      @state.get('game').set('start', new Date() - 60*1000 - 1)
      @state.trigger('change:game')

      expect(@wp.$('.inactive-word-panel').length > 0).toBeTruthy()
      expect(@wp.$('.word-input-input:disabled').length > 0).toBeTruthy()

    it 'should render correctly a word being typed', ->
      @state.set('game', new Game())
      @state.get('currentWord').set('literal', 'something')

      expect(@wp.$('.word-panel').length > 0).toBeTruthy()
      expect(@wp.$('.word-input-input:not(:disabled)').length > 0).toBeTruthy()
      expect(@wp.$('.word-input-points').length > 0).toBeTruthy()

    it 'should render correctly the added words', ->
      game = new Game()
      game.set('words', [new Word(literal: 'foo'), new Word(literal: 'bar')])
      @state.set('game', game)

      expect(@wp.$('.word-panel').length > 0).toBeTruthy()
      expect(@wp.$('.word-input-input:not(:disabled)').length > 0).toBeTruthy()
      expect(@wp.$('.word-item').length).toBe(2)

  describe 'DOM events', ->
    it 'should add a submitted word to the list when .word-input-form is submitted', ->
      game = new Game()
      @state.set('game', game)
      currentWord = @state.get('currentWord')
      currentWord.set('isReal', true)
      literal = game.get('board')[0][0]
      currentWord.set('literal', literal)
      @wp.$('.word-input-form').submit()

      expect(game.get('words').length).toBe(1)
      expect(game.get('words')[0].get('literal')).toBe(literal)
      expect(currentWord.get('literal')).toBe('')

    it 'should update currentWord when .word-input is inputted', ->
      @state.set('game', new Game())
      currentWord = @state.get('currentWord')
      @wp.$('.word-input-input').val('foo').trigger('input')

      expect(currentWord.get('literal')).toBe('foo')

