var map, markers = [], lines = [];

window.onload = function(){
	$(document).bind("keyup keydown", function(e){
    	if(e.ctrlKey && e.keyCode == 76)
        	resetMap();
        	$("#query-text").focus();
	});
};

function initMap() {
	map = new google.maps.Map(document.getElementById('map'), {
		mapTypeId: 'roadmap',
    	center: {lat: 41.158, lng: -8.629},
    	zoom: 2
    });
}

function centerMap() {
	map.panTo({lat: 41.158, lng: -8.629});
	map.setZoom(2);
}

function removeLines() {
	for (var i = 0; i < lines.length; i++)
    	lines[i].setMap(null);
    lines = [];
}

function removeMarkers() {
	for (var i = 0; i < markers.length; i++)
    	markers[i].setMap(null);
    markers = [];
}

function resetMap() {
	removeLines();
	removeMarkers();
	centerMap();
	$("#show-error").hide();
	$("#query-text").val("");
	$("#response-list").hide();
	$("#query-text").focus();
}

function query() {
	var question = $('#query-text').val();

	question = question.toLowerCase();
	question = question.replace('?','');
	$.ajax({
	    type: 'GET',
	    contentType: 'text/plain',
	    url: '/query?question='+question,
	    //data: question,
	    success: function(response){
	    	console.log(response);
	    	var response_array = response.replace(new RegExp(/[\[\]]/g), "").split(",");

	    	if (question.indexOf("rivers") >= 0)
	    		displayRivers(response_array);
	    	else if (question.indexOf("capital") >= 0)
	    		displayCapitals(response_array);
	    	else if (question.indexOf("largest city") >= 0)
	    		displayCapitals(response_array);
	    	else if (question.indexOf("largest country") >= 0)
	    		displayCountries(response_array);
	    	else if (question.indexOf("countries") >= 0)
	    		displayCountries(response_array);
	    	else if (question.indexOf("cities") >= 0 && question.indexOf("continents") == -1)
	    		displayCities(response_array);
	    	else if (question.indexOf("bordering") >= 0)
	    		displayCountries(response_array);

	    	$("#response-list").show();
	    	$("#error").text("");
	    	$("#show-error").hide();
	    	showResponseOnList(response_array);
	    	
	    },
	    error: function(response){
	    	console.log("FAIL");
    		sentences = ["Do you think this is funny?","I know where you live!","Stop playing around!","Are you dumb?"];
    		var sentence = sentences[Math.floor(Math.random()*sentences.length)];
    		//alert(sentence);
    		$("#show-error").show();
    		$("#error").text(sentence);
	    }
	});
}

function showResponseOnList(response_array) {
	$('#response-list').empty();
	//var response_array = response.replace(new RegExp(/[\[\]]/g), "").split(",");
	for (var i = 0; i < response_array.length; i++) {
        var li = document.createElement('li');
        li.innerHTML = response_array[i];
        $('#response-list').append(li);
    }
}

function displayRivers(rivers_array) {
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
	    	var coords_array = response.substring(2,response.length-3).split("],[");

	    	for (var i = 0; i < coords_array.length; i++) {
	    		var lat = coords_array[i].split(",")[0];
	    		var lng = coords_array[i].split(",")[1];
	    		var coords_json = {"lat":parseFloat(lat), "lng":parseFloat(lng)};
 				json_coords_array.push(coords_json);
			}

			drawLine(river, json_coords_array);
	    }
	});
}

function displayCapitals(capital_array) {
	//var capital = response.substring(1,response.length-2);
	console.log(capital_array[0]);
	displayCapital(capital_array[0]);
}

function displayCapital(capital) {
	
	$.ajax({
	    type: 'GET',
	    contentType: 'text/plain',
	    url: '/coords?capital=' + capital,
	    success: function(response){
	    	console.log(response);
	    	var coords_array = response.substring(2,response.length-3).split(",");
	    	console.log(coords_array);
    		var lat = coords_array[0];
    		var lng = coords_array[1];
    		var coords_json = {"lat":parseFloat(lat), "lng":parseFloat(lng)}
			
			createMarker( capital, coords_json);
			map.panTo(coords_json);
			map.setZoom(4);
			console.log(lat+":"+lng);
	    }
	});
}

function displayCountries(countries_array) {
		if (countries_array.length == 1) {
			console.log(countries_array[0]);
			displayCountry(countries_array[0]);
		}
		else {
			for (var i = 0; i < countries_array.length; i++){
				console.log(countries_array[i]);
				country = countries_array[i];
				displayCountry2(country);
			}
		}
}

function displayCountry(country) {

	$.ajax({
	    type: 'GET',
	    contentType: 'text/plain',
	    url: '/coords?country=' + country,
	    success: function(response){
	    	console.log(response);
	    	
    		var coords_array = response.substring(2,response.length-3).split("],[");
	    	console.log(coords_array);

	    	for (var i = 0; i < coords_array.length; i++) {
	    		var lat = coords_array[i].split(",")[0];
	    		var lng = coords_array[i].split(",")[1];
	    		var coords_json = {"lat":parseFloat(lat), "lng":parseFloat(lng)}
	    		createMarker( country, coords_json);
			    map.panTo(coords_json);
			}

			map.setZoom(3);
	    }
	});
}

function displayCountry2(country) {

	$.ajax({
	    type: 'GET',
	    contentType: 'text/plain',
	    url: '/coords?capital=' + country,
	    success: function(response){
	    	console.log(response);
	    	
    		var coords_array = response.substring(2,response.length-3).split("],[");
	    	console.log(coords_array);

	    	for (var i = 0; i < coords_array.length; i++) {
	    		var lat = coords_array[i].split(",")[0];
	    		var lng = coords_array[i].split(",")[1];
	    		var coords_json = {"lat":parseFloat(lat), "lng":parseFloat(lng)}
	    		createMarker( country, coords_json);
			    map.panTo(coords_json);
			}

			map.setZoom(3);
	    }
	});
}


function displayCities(cities_array) {
		console.log(cities_array.length);
		for (var i = 0; i < cities_array.length; i++){
			console.log(cities_array[i]);
			city = cities_array[i];
			displayCity(city);
		}
}

function displayCity(city) {
	
	$.ajax({
	    type: 'GET',
	    contentType: 'text/plain',
	    url: '/coords?city=' + city,
	    success: function(response){
	    	//console.log("resposta: "+response);
	    	
    		var coords_array = response.substring(2,response.length-3).split("],[");
	    	//console.log("coords array: "+coords_array);

	    	for (var i = 0; i < coords_array.length; i++) {
	    		var lat = coords_array[i].split(",")[0];
	    		var lng = coords_array[i].split(",")[1];
	    		var coords_json = {"lat":parseFloat(lat), "lng":parseFloat(lng)}
	    		if (lat!==undefined && lng!==undefined){
		    		createMarker( city, coords_json);
				    map.panTo(coords_json);
				}
			}

			map.setZoom(3);
	    }
	});
}


function drawLine(name, path) {
	var line = new google.maps.Polyline({
		path: path,
		title: name,
		geodesic: true,
		strokeColor: '#06425C',
		strokeOpacity: 1.0,
		strokeWeight: 4
	});
  	lines.push(line);
  	line.setMap(map);
}

function createMarker(name, myLatLng){
	var marker = new google.maps.Marker({
       position: myLatLng,
       map: map,
       title: name
    });
    markers.push(marker);
}