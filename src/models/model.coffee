_ = require('lodash')

window._ = _

class Model
  constructor: (attrs = {})->
    @attributes = attrs
    @listeners = {}

  set: (key, value)->
    @attributes[key] = value
    if value instanceof Model
      value.on 'all', (args)=>
        @trigger("change:#{key}", args.slice(1)...)
        subevent = args[0]
        @trigger("change:#{key}:#{subevent}", args.slice(1)...)

    @trigger("change:#{key}")

  get: (key)->
    @attributes[key]

  trigger: (args...)->
    event = args[0]
    _.forEach @listeners[event] || [],  (l)->
      l.apply undefined, args

    _.forEach @listeners['all'] || [],  (l)->
      l.apply undefined, args

  on: (event, callback)->
    @listeners[event] ||= []
    @listeners[event].push callback

window.Model = Model
module.exports = Model
