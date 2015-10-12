var express = require('express');
var request = require("request");
var app = express();

app.use(express.static('public'));

app.get('/words/:word', function (req, res) {
  request(
    "https://en.wiktionary.org/w/api.php", 
    {qs: {action: 'query', format: 'json', titles: req.params.word}}, 

    function(error, response, body) {
      json = JSON.parse(body)
      isReal = !json['query']['pages'][-1]
      res.send({isReal: isReal});
  });
});

var server = app.listen(3000, function () {
  console.log("Running at http://localhost:3000");
});
