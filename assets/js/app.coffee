"use strict"

# Declare app level module which depends on filters, and services
angular.module("myApp", ["ui","myApp.filters", "myApp.services", "myApp.directives"]).config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
  $routeProvider.when "/view1",
    templateUrl: "partials/view1"
    controller: MyCtrl1

  $routeProvider.when "/view2",
    templateUrl: "partials/view2"
    controller: MyCtrl2

  $routeProvider.otherwise redirectTo: "/view1"
  $locationProvider.html5Mode true
]