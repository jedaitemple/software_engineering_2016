var express = require('express');
var router = express.Router();

var http = require('http');
var url = require('url');

var handler = require('../modules/handler.js');

var port = 8120;
var hostname = 'localhost'

router.get('/', function(request, response) {
	var query = url.parse(request.url, true).query;

	if(query.image != null){
		handler.provideData('./images/'+ query.image +'.jpg',{'Content-Type': 'image/jpeg'}, response);
	} else if (query != null && Object.keys(query).length > 0) {
		handler.queryData('./data/data.json', {'Content-Type': 'application/json'}, query.type, response);
	} else {
		handler.provideData('./data/data.json', {'Content-Type': 'application/json'}, response);
	}
});

module.exports = router;
