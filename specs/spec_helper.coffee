global.window = require("jsdom").jsdom('<html>')._defaultView
global.document = window.document

Model = require '../src/models/model'
Word = require '../src/models/word'

Helper = {
  makeState: ->
    state = new Model()
    state.set('game', undefined)
    state.set('currentWord', new Word(literal: ''))
    state.set('activeWord', undefined)

    state
}
module.exports = Helper
