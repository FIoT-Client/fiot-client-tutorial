var express = require('express');
const bodyParser = require('body-parser');

let PORT = 3333;

var app = express();

app.use(function(req, res, next) {
  req.rawBody = '';
  req.setEncoding('utf8');

  req.on('data', function(chunk) {
    req.rawBody += chunk;
  });

  req.on('end', function() {
    next();
  });
});

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false}));

app.post('/', function (req, res) {
  let rawBody = req.rawBody;
  var rawBodySplitted = rawBody.split('@');
  var deviceId = rawBodySplitted.shift();

  var rawParams = rawBodySplitted.toString().split('|')
  var commandName = rawParams.shift();
  var commandParams = rawParams;

  console.log(`${new Date()}: Device ${deviceId} - Command ${commandName} - Params ${commandParams}`);

  var commandResult = 'Done';

  var responsePayload = `${deviceId}@${commandName}|${commandResult}`;
  res.send(responsePayload);
});

app.listen(PORT, function () {
  console.log('Simple command endpoint on port 3333!');
});
