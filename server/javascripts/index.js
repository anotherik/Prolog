var map, markers = [], lines = [];

function initMap() {
	map = new google.maps.Map(document.getElementById('map'), {
		mapTypeId: 'roadmap',
    	center: {lat: 41.158, lng: -8.629},
    	zoom: 3
    });
}

function resetMap() {
	map.panTo({lat: 41.158, lng: -8.629});
	map.setZoom(3);
	//map.setCenter(new google.maps.LatLng(41.158, -8.629));
}

function query() {
	var question = $('#queryForm').serialize();
	var second_word = $('#query-text').val().split(" ")[1];

	$.ajax({
	    type: 'GET',
	    contentType: 'text/plain',
	    url: '/query',
	    data: question,
	    success: function(response){
	    	console.log(response);

	    	if (second_word == "rivers")
	    		dispalyRivers(response);
	    }
	});
}

function dispalyRivers(response) {
	var rivers_array = response.substring(1,response.length-2).split(",");
	for (var i = 0; i < rivers_array.length; i++)
		displayRiver(rivers_array[i]);
}

function displayRiver(river) {
	var json_coords_array = [];
	$.ajax({
	    type: 'GET',
	    contentType: 'text/plain',
	    url: '/coords?river=' + river,
	    success: function(response){
	    	//console.log(river);
	    	//console.log(response);
	    	var coords_array = response.substring(2,response.length-3).split("],[");
	    	//console.log(coords_array.length);

	    	for (var i = 0; i < coords_array.length; i++) {
	    		var lat = coords_array[i].split(",")[0];
	    		var lng = coords_array[i].split(",")[1];
 				json_coords_array.push({"lat":parseFloat(lat), "lng":parseFloat(lng)});
			}
			//console.log(json_coords_array);
			drawLine(json_coords_array);
	    }
	});
}

function drawLine(path) {
	var line = new google.maps.Polyline({
		path: path,
		geodesic: true,
		strokeColor: '#06425C',
		strokeOpacity: 1.0,
		strokeWeight: 4
	});
  	lines.push(line);
  	line.setMap(map);
}