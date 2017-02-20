var http = require('http');
var url = require('url');
var dataProvider = require('./modules/handler.js');

var port = 8124;
var hostname = 'localhost';

function handleRequest(request, response)
{
	if (request.url ==='/favicon.ico')
	{
		console.log('Ignore facicon request...');
	}
	else
	{	
		var get_params = url.parse(request.url, true);
		if (get_params.query.image != null && get_params.query.image != null)
		{
			dataProvider.provideData('image/image.jpg',{'Content-Type': 'image/jpeg'}, response);
		}
		else (get_params.query.data != null && get_params.query.data != null)
		{
			dataProvider.provideData('data/data.json',{'Content-Type': 'application/json', 'Image-Url' : 'http://localhost:' + port + '?image' }, response);
		}
	}
}

console.log('listening on localhost:8124');

http.createServer(handleRequest).listen(port, hostname);
