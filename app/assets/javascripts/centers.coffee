# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


`
var main = function(){
	var page_id = $('.main').data('pageId');
	if( page_id === "index"){
		
		var search = $('#map-canvas').data('query');
		var page = $('#map-canvas').data('page');
		var url_params ="";
		console.log(search);
		console.log(page);

		if( page === "" ){
			console.log("?utf8=%E2%9C%93&search=" + search);
			url_params = "?utf8=%E2%9C%93&search=" + search;
		}else if (page >= 1 ){
			console.log("?page="+page+"&search="+search+"&utf8=%E2%9C%93");
			url_params = "?page="+page+"&search="+search+"&utf8=%E2%9C%93";
		}


		$.getJSON('centers.json'+ url_params,  function(data){
	            console.log(data);
	            showMaps( data);
	            $.each(data, function(index){
	               var search_id = data[index].id,
	               		site_name = data[index].site_name,
	               	   	longitude = data[index].longitude,
	        	   	   	latitude =  data[index].latitude;
	        	   	   	console.log(site_name, longitude, latitude);
	            });
	     });

	} else if ( page_id === "show"){
		
		 var center_id = $('#map').data('centerId');

	     $.getJSON(center_id + '.json', function(data){
	     	var site_name = data.site_name,
	     		longitude = data.longitude,
	     		latitude = data.latitude;
	     		console.log(site_name, longitude, latitude);
	     		showMap(data);
	     });

	}


	var showMaps = function(data){
		var lat = data[0].latitude, lng = data[0].longitude;

		var map = L.map('map-canvas', {
			center : [lat,  lng],		
			zoom: 15

		});

		var RedIcon = L.Icon.Default.extend({
			options: {
				iconUrl: 'marker-icon-red.png'
			}
		});

		var redIcon = new RedIcon();

		L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
			attribution: '&copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors',
			maxZoom: 18
		}).addTo(map);

		/*
		L.tileLayer( 'http://{s}.mqcdn.com/tiles/1.0.0/map/{z}/{x}/{y}.png', {
	    	attribution: '&copy; <a href="http://osm.org/copyright" title="OpenStreetMap" target="_blank">OpenStreetMap</a> contributors | Tiles Courtesy of <a href="http://www.mapquest.com/" title="MapQuest" target="_blank">MapQuest</a> <img src="http://developer.mapquest.com/content/osm/mq_logo.png" width="16" height="16">',
	    	subdomains: ['otile1','otile2','otile3','otile4']
			}).addTo( map );
		
		$.each(data, function(index){
			L.marker( [data[index].latitude, data[index].longitude])
				.bindPopup( '<a href="' + data[index].website + '">' + data[index].site_name + '</a>')
				.addTo( map );
		});*/
	}

	var showMap = function(data) {
		var lat = data.latitude, lng = data.longitude;

		var map = L.map('map', {
			center : [lat,  lng],		
			zoom: 15

		});

		var RedIcon = L.Icon.Default.extend({
			options: {
				iconUrl: 'marker-icon-red.png'
			}
		});

		var redIcon = new RedIcon();

		L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
			attribution: '&copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors',
			maxZoom: 18
		}).addTo(map);
		/*
		L.marker( [data[index].latitude, data[index].longitude])
				.bindPopup( '<a href="' + data[index].website + '">' + data[index].site_name + '</a>')
				.addTo( map );*/
	}

	
    
}

$(document).ready(main);

`