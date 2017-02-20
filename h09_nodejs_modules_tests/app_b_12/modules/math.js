function disc (a,b,c) {
	D = (b*b) - (4*a*c);
	return D;
}

function integer (num) {
	if (num % 1 == 0) return num;
	else return num.toFixed(2);
}

exports.solve = function (a,b,c) {

	var result = {};

	if (a == 0) {

	if (b == 0 && c == 0) {
		result.x = "Any";
		console.log(JSON.stringify(result));
		return;
	}
	
	if (b != 0) {
	result.x = integer((- c) / b);
	}

	}
	
	if (a != 0) {
	var D = disc(a,b,c);
	
	if (D > 0) {
	
		var x1 = (- b + Math.sqrt(D)) / (2 * a);
		var x2 = (- b - Math.sqrt(D)) / (2 * a);
		
		result.x1 = integer(x1);
		result.x2 = integer(x2);
	}
	
	if (D == 0) {
		var x = (- b) / (2 * a);
		result.x = integer(x);
	}
	
	if (D < 0) {
		result.x1 = "NaN";
		result.x2 = "NaN";
	}
	
	}

	console.log(JSON.stringify(result, null, 2));
	
}
