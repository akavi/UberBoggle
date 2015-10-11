$ = require('jquery')
BoggleApp = require('./components/boggle_app')

$ ->
  app = new BoggleApp()
  console.log app.el
  $('.h-main').html app.el
