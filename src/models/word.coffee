Model = require './model'
$ = require 'jquery'

class Word extends Model

  checkReality: ->
    @set('isReal', undefined)
    literal = @get('literal')

    onSuccess = (json)=>
      @set('isReal', json.isReal)

    $.get "/words/#{literal}", {}, onSuccess
  
  value: ->
    @get('literal').length

module.exports = Word
