var http = require('http');
var url = require('url');
var port = 8101;
var dataProvider = require('./modules/handle_module.js');

function handleRequest(request, response)
{
  var get_params = url.parse(request.url, true);
  if (get_params.query.image != null && get_params.query.image != null)
  {
    dataProvider.provideData('images/'+get_params.query.image+'.jpg',{'Content-Type': 'image/jpeg'}, response)
  }
  if (Object.keys(get_params.query).lenght)
 		{

      dataProvider.queryData('data/data.json',{'Content-Type': 'application/json'}, get_params.query, response);

 		}else{

    dataProvider.provideData('./data/data.json', {'Content-Type': 'application/json','Image-Url':'http://localhost:8101/?image'}, response);
  }

}

console.log('listening on localhost:8101');


http.createServer(handleRequest).listen(port, '127.0.0.1');
