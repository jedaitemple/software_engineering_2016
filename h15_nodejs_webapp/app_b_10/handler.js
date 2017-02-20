var fs = require('fs');
function DataReader(filename, contentType, response)  {
  console.log('providing ' + filename);
  fs.exists(filename, function(exists) {
    if (exists) {
      fs.readFile(filename, function(error, data) { 
        if (!error) {
          response.writeHead(200, contentType);
          response.end(data);
        }
        else {
          response.writeHead(500);
          response.end('Internal Server Error');
        }
      });
    }
    else    {
      response.writeHead(404);
      response.end('Image not found');
    }
  });
}
exports.provideData = function(filename, contentType, response) {
  return DataReader(filename,contentType, response);
} 
