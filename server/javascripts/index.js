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
	var question = $('#query-text').val();//.serialize();
	var second_word = $('#query-text').val().split(" ")[1];
	var third_word = $('#query-text').val().split(" ")[2];

	$.ajax({
	    type: 'GET',
	    contentType: 'text/plain',
	    url: '/query?question='+question,
	    //data: question,
	    success: function(response){
	    	console.log(response);

	    	if (second_word == "rivers")
	    		dispalyRivers(response);
	    	else if (third_word == "capital")
	    		dispalyCapitals(response);
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

function dispalyCapitals(response) {
	var capital = response.substring(1,response.length-2);
	console.log(capital);
	displayCapital(capital);
}

function displayCapital(capital) {
	
	$.ajax({
	    type: 'GET',
	    contentType: 'text/plain',
	    url: '/coords?capital=' + capital,
	    success: function(response){
	    	var coords_array = response.substring(2,response.length-3).split("],[");
	    
    		var lat = coords_array[0];
    		var lng = coords_array[1];
			
			createMarker( capital, {"lat":parseFloat(lat), "lng":parseFloat(lng)} );
			console.log(lat+":"+lng);
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

function createMarker(capital, myLatLng){
	var marker = new google.maps.Marker({
       position: myLatLng,
       map: map,
       title: capital
    });
}