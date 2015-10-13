$ = require('jquery')
App = require('./components/app')

$ ->
  app = new App()
  $('.h-main').html app.el
