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
    $scope.myData = [{name: "Moroni", age: 50},
        {name: "Tiancum", age: 43},
        {name: "Jacob", age: 27},
        {name: "Nephi", age: 29},
        {name: "Enos", age: 34}]
    $scope.gridOptions = { data: 'myData' }

MyCtrl2.$inject = ['$scope','$http']