Model = require './model'

class Word extends Model

  checkReality: ->
    #TODO
  
  value: ->
    @get('literal').length

module.exports = Word
