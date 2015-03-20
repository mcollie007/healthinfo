var clinicGeoToMarkers = function(data) {

	var centers = data
	var markers = []

	for(var i=0; i<centers.length; i++){
		center = {
			lat: centers[i].latitude,
			lng: centers[i].longitude,
			message: getMessage(centers[i].site_name)
		}
		markers.push(center)
	}
	return markers;
}