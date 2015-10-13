require('../spec_helper')

App = require('../../src/components/app')
Model = require('../../src/models/model')
Word = require('../../src/models/word')

describe "App", ->
  beforeEach ->
    @app = new App()

  describe 'intialization', ->
    it 'intializes @el', ->
      expect(@app.el).toBeTruthy()

    it 'intializes @state', ->
      expect(@app.state.get('game')).toEqual(undefined)
      expect(@app.state.get('currentWord').get('literal')).toEqual('')
      expect(@app.state.get('activeWord')).toEqual(undefined)

  describe '#render', ->
    it 'renders correctly', ->
      @app.render()
      # main template
      expect(@app.$('.content').length > 0).toBeTruthy()
      # board subcomponent
      expect(@app.$('.board').length > 0).toBeTruthy()
      # controlPanel subcomponent
      expect(@app.$('.control-panel').length > 0).toBeTruthy()
      # wordPanel subcomponent
      expect(@app.$('.inactive-word-panel').length > 0).toBeTruthy()
