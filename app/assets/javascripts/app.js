var app = angular.module('ClinicSquare', ['leaflet-directive', 'ngRoute']);
/*app.config([]{});*/
app.factory('centers', ['$http', function($http){

	return $http.jsonp('/centers.json')
		.success(function(data){
			return data
		});

}]);

app.controller('MainController', ['scope', 'centers', function($scope, centers){

	centers.success(function(data){

		centers.success(function(data){
			$scope.data = data;
			$scope.mapMarkers = clinicGeoToMarkers($scope.data)
		})

	});
}]);