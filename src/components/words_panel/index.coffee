$ = require('jquery')
template = require('./template')

class WordsPanel
  constructor: ->
    @el = $('<div>')
    @el.html template(@data())

  data: ->
    words: [
      {literal: 'foo', value: 3}
      {literal: 'bacon', value: 5}
      {literal: 'something', value: 5}
    ]

    currentWord: 'foo'
    isValid: true
    currentPoints: 3
    isChecking: false
    isntReal: true
    isntUnique: false
    isntOnBoard: false

module.exports = WordsPanel
