"use strict"

# Controllers 
@AppCtrl = ($scope, $http) ->
  $http(
    method: "GET"
    url: "/api/name"
  ).success((data, status, headers, config) ->
    $scope.name = data.name
  ).error (data, status, headers, config) ->
    $scope.name = "Error!"

@MyCtrl1 = ($scope, $http) ->
	$scope.name = "World"
MyCtrl1.$inject = ['$scope','$http']


@MyCtrl2 = ($scope, $http) ->
	$scope.name = "Bear"
MyCtrl2.$inject = ['$scope','$http']