var http = require('http');
var url = require('url');

var port = 8217;
var hostname = '127.0.0.1';

var responseWriter = require('./modules/writeResponse.js');

function requestHandle(request, response) {
    var params = url.parse(request.url, true);
    
    if(params.query.image != null) {
    	responseWriter.responseWriter('./image/image.jpeg', 
        		{'Content-Type': 'image/jpeg'}, response);
    } 
    else {
    	responseWriter.responseWriter('./data/data.json', 
    			{'Content-Type': 'application/json', 
    			'Image-url':'localhost:8217/?image'}, response);
    }
}

http.createServer(requestHandle).listen(port, hostname);
