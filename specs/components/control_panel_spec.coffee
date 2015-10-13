Helper = require('../spec_helper')
ControlPanel = require('../../src/components/control_panel')
Game = require('../../src/models/game')

describe 'ControlPanel', ->
  beforeEach ->
    @state = Helper.makeState()
    @cp = new ControlPanel(state: @state)

  describe 'rendering', ->
    it 'renders correctly initially', ->
      expect(@cp.$('.start-button').length > 0).toBeTruthy()
      expect(@cp.$('.time-left').length > 0).toBeFalsy()
      expect(@cp.$('.times-up').length > 0).toBeFalsy()
      expect(@cp.$('.points-display').length > 0).toBeFalsy()
      expect(@cp.$('.quit-button').length > 0).toBeFalsy()
      expect(@cp.$('.replay-button').length > 0).toBeFalsy()

    it 'renders correctly when in game', ->
      @state.set('game', new Game())

      expect(@cp.$('.start-button').length > 0).toBeFalsy()
      expect(@cp.$('.time-left').length > 0).toBeTruthy()
      expect(@cp.$('.times-up').length > 0).toBeFalsy()
      expect(@cp.$('.points-display').length > 0).toBeTruthy()
      expect(@cp.$('.quit-button').length > 0).toBeTruthy()
      expect(@cp.$('.replay-button').length > 0).toBeFalsy()

    it 'renders correctly when post game', ->
      @state.set('game', new Game())
      @state.get('game').set('start', new Date() - 60*1000 - 1)

      expect(@cp.$('.start-button').length > 0).toBeFalsy()
      expect(@cp.$('.time-left').length > 0).toBeFalsy()
      expect(@cp.$('.times-up').length > 0).toBeTruthy()
      expect(@cp.$('.points-display').length > 0).toBeTruthy()
      expect(@cp.$('.quit-button').length > 0).toBeFalsy()
      expect(@cp.$('.replay-button').length > 0).toBeTruthy()

  describe 'DOM events', ->
    it 'updates state correctly when .start-button clicked', ->
      @cp.$('.start-button').click()

      expect(@cp.state.get('game')).toEqual(jasmine.any(Game))
      expect(@cp.state.get('currentWord').get('literal')).toEqual('')

    it 'updates state correctly when .quit-button clicked', ->
      @cp.state.get('currentWord').get('literal', 'nonempty')
      @cp.$('.quit-button').click()

      expect(@cp.state.get('game')).toEqual(undefined)
      expect(@cp.state.get('currentWord').get('literal')).toEqual('')

    it 'updates state correctly when .replay-button clicked', ->
      @state.set('game', new Game())
      @cp.state.get('currentWord').get('literal', 'nonempty')
      @cp.$('.replay-button').click()

      expect(@cp.state.get('game')).toEqual(jasmine.any(Game))
      expect(@cp.state.get('currentWord').get('literal')).toEqual('')
