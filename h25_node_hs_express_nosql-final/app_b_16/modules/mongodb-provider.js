/**
 * New node file
 */

var models = require('../model/character.js');

var Character = models.Character;

exports.provideList = function(response) {

	Character.find({}, function(error, result) {
		if (error) {
			console.error(error);
			return null;
		}
		if (result != null) {
			response.json(result);
		}
	});

};


exports.queryData = function(headers, ReqQuery, response,type) {
	ReqQuery['type'] = type ;
	Character.find(ReqQuery, function(error, result) {
		if (error) {
			console.error(error);
			return null;
		}
		if (result != null) {
			response.writeHead(200, {
				'Content-Type':'application/json',
				'Image-Url':'http://localhost:8216/'+ ReqQuery.type + '/image'});
			response.end(JSON.stringify(result));
		}
		
	});

};

exports.saveCharacter = function(request, response)
{
	var character = toCharacter(request.body);
	character
			.save(function(error) {
				if (!error) {
					response.writeHead(201, {
						'Content-Type' : 'application/json'
					});
					response.end(JSON.stringify(request.body));
				} else {
					Character
							.findOne(
									{
										firstname : character.firstname
									},
									function(error, result) {
										console.log('Check if such a character exists');
										if (error) {
											console.log(error);
											response.writeHead(500, {
												'Content-Type' : 'text/plain'
											});
											response.end('Internal Server Error');
										} else {
											if (!result) {
												console
														.log('Character does not exist. Create new one');
												character.save();
												response.writeHead(201, {
													'Content-Type' : 'application/json'
												});
												response.end(JSON.stringify(request.body));
											} else {
												console.log('Character already exists will be updated');
												result.firstname = character.firstname;
												result.lastname = character.lastname;
												result.type = character.type;
												result.imageUrl = character.imageUrl;										result.lastname = character.lastname;
												result.save();
												response.json(request.body);
											}
											
										}
									});
				}
			});
};


exports.saveImage = function(request, response) {
	
	
	var writeStream = models.Grid.createWriteStream({
		filename: request.params.type,
		mode : 'w'
	});
	
	writeStream.on('error', function(error) {
		response.send('500', 'Internal Server Error');
		console.log('error write');
		return;
	})
	
	writeStream.on('close', function() {
		var readStream = models.Grid.createReadStream({
			filename : request.params.type,
			mode : 'r'
		});
		
		readStream.on('error', function(error) {
			console.log('error read');
			console.log(error);
			response.send('500', 'Internal Server Error');
			return;
		});
		
		response.writeHead(200, {'Content-Type' : 'image/jpeg'});
		readStream.pipe(response);
	});
	
	request.pipe(writeStream);

};

exports.getImage = function(request, response) {
	models.Grid.exist({filename : request.params.type}, function(error, found) {
        if (error) {
            response.send('500', 'Internal Server Error');
            return;
        } else if(found) {
            var readStream = models.Grid.createReadStream({
                filename : request.params.type,
                mode : 'r'
            });

            readStream.on('error', function(error) {
                console.log('error read');
                console.log(error);
                response.send('500', 'Internal Server Error');
                return;
            });

            response.writeHead(200, {'Content-Type' : 'image/jpeg'});
            readStream.pipe(response);
		} else {
            response.writeHead(404);
            response.end('Image for this type, NOT FOUND');
            return;
		}
	});
};

function toCharacter(characterObject) {
	return new Character({
		firstname : characterObject.firstname,
		lastname : characterObject.lastname,
		strength : characterObject.strength,
		imageUrl : characterObject.imageUrl,
		type : characterObject.type

	});
}
