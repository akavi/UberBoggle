$ = require('jquery')
BoggleApp = require('./components/boggle_app')

$ ->
  app = new BoggleApp()
  $('.h-main').html app.el
