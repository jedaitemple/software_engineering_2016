var http = require('http');
var url = require('url');
var dataProvider = require('./modules/data-provider.js');

var port = 8113;
var hostname = 'localhost';

function handleRequest(request, response) 
{
    var get_params = url.parse(request.url, true);

    if(get_params.query.image != null)
    {
        dataProvider.provideData('./images/' + get_params.query.image + '.jpeg', {'Content-Type': 'image/jpeg'}, response);
    } 
    
    else if (Object.keys(get_params.query).length) 
    {
        dataProvider.queryData('./data/data.json',{'Content-Type': 'application/json'}, get_params.query, response);
	} 
    
    else 
    {
        dataProvider.provideData('./data/data.json', {'Content-Type': 'application/json'}, response);
    }
}



http.createServer(handleRequest).listen(port, hostname);