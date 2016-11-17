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
	$.ajax({
	    type: 'GET',
	    contentType: 'text/plain',
	    url: '/query',
	    data: $('#queryForm').serialize(),
	    success: function(response){
	    	console.log(response);
	    	alert(response);
	    }
	});
}