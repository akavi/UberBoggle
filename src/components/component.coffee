$ = require('jquery')

class Component
  constructor: ->
    @el = $('<div>')

  $: (selector)->
    @el.find(selector)

  render: =>
    @el.html @template(@data())

  subRender: (selector)=>
    =>
      fragment = $(@template(@data()))
      subHtml = fragment.find(selector).html()
      # jQuery won't return toplevel elements with #find
      # eg, $('<p>foo</p>').find('p') => []
      # so we do the below
      subHtml ?= fragment.closest(selector).html()
      @el.find(selector).html subHtml

  data: ->
    {}

module.exports = Component
