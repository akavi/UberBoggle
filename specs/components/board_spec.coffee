Helper = require('../spec_helper')
Board = require('../../src/components/board')
Game = require('../../src/models/game')

describe 'Board', ->
  beforeEach ->
    @state = Helper.makeState()
    @board = new Board(state: @state)

  describe 'rendering', ->
    it 'renders correctly initially', ->
      expect(@board.$('.inactive-board-tile').length).toBe(16)

    it 'renders correctly when in game', ->
      @state.set('game', new Game())

      expect(@board.$('.board-tile').length).toBe(16)

    it 'renders correctly when post game', ->
      @state.set('game', new Game())
      @state.get('game').set('start', new Date() - 60*1000 - 1)
      expect(@board.$('.inactive-board-tile').length).toBe(16)
