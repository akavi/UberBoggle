_ = require('lodash')

class Model
  constructor: (attrs = {})->
    @attributes = attrs
    @listeners = {}

  set: (key, value)->
    @attributes[key] = value
    if value instanceof Model
      value.on 'all', (args)=>
        @trigger("change:#{key}", args.slice(1)...)
        @trigger("change:#{key}:#{args[0]}", args.slice(1)...)

    @trigger("change:#{key}")

  get: (key)->
    @attributes[key]

  trigger: (args...)->
    event = args[0]
    _(@listeners[event]).each (l)->
      l.apply undefined, args
    _(@listeners['all']).each (l)->
      l.apply undefined, args

  on: (event, callback)->
    @listeners[event] ||= []
    @listeners[event].push callback

window.Model = Model
module.exports = Model
