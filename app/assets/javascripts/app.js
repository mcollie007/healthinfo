var app = angular.module('ClinicSquare', ['leaflet-directive']);
/*app.config([]{});*/
app.factory('centers', ['$http', function($http){
	var o = {
		centers: []
	};



	o.showMap = function(id){
		return $http.jsonp('/centers/' + id +'.json')
	}

	o.getSearch = function(search) {
		return $http.jsonp('/centers.json?utf8=%E2%9C%93&search='+ Search)
			.success(function(data){
				return data
			});
	}

	return o;

}]);


app.controller('MainController', ['scope', 'centers', 'center', function($scope, centers, center){

	$scope.center = center;

	$scope.showMap = function(){
		center.showMap(center.id).success(function(data){
			$scope.data = data;
			$scope.mapMarkers = clinicGeoToMarkers($scope.data)
		});
	}
/*
	$scope.showMaps = function(){
		centers.success(function(data){
			$scope.data = data;
			$scope.mapMarkers = clinicGeoToMarkers($scope.data)
		});
	}*/


		


}]);