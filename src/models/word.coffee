Model = require './model'
$ = require 'jquery'

class Word extends Model

  checkReality: ->
    @set('isReal', undefined)
    literal = @get('literal')

    onSuccess = (json)=>
      @set('isReal', true)

    setTimeout onSuccess, 1000
  
  value: ->
    @get('literal').length

module.exports = Word
