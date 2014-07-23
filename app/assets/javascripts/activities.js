var activityApp = angular.module('activity-app', ['ngResource', 'ui.router', 'templates']).config(
    ['$httpProvider', function($httpProvider) {
    var authToken = angular.element("meta[name=\"csrf-token\"]").attr("content");
    var defaults = $httpProvider.defaults.headers;

    defaults.common["X-CSRF-TOKEN"] = authToken;
    defaults.patch = defaults.patch || {};
    defaults.patch['Content-Type'] = 'application/json';
    defaults.common['Accept'] = 'application/json';
}]);

activityApp.config(function($stateProvider, $urlRouterProvider) {
  //
  // For any unmatched url, redirect to /home
  $urlRouterProvider.otherwise("/home");
  //
  // Now set up the states
  $stateProvider
    .state('home', {
      url: "/home",
      templateUrl: "home.html"
    })
    .state('newActivity', {
      url: "/newActivity",
      templateUrl: "activity_form.html"
    })
    .state('search', {
      url: "/search",
      templateUrl: "search.html"
    })
  });

activityApp.factory('Activity', ['$resource', function($resource) {
  return $resource('/activities/:id',
     {id: '@id'},
     {update: { method: 'PATCH'}});
}]);

activityApp.controller('ActivityCtrl', ['$scope', 'Activity', function($scope, Activity) {
    $scope.activities= [];

    $scope.newActivity = new Activity();

    Activity.query(function(activities) {
      $scope.activities = activities;
   });

    $scope.saveActivity = function () {
      $scope.newActivity.$save(function(activity) {
      $scope.activities.push(activity);
      $scope.newActivity = new Activity();
      });
    };

    $scope.deleteActivity = function (activity) {
      activity.$delete(function() {
        position = $scope.activities.indexOf(activity);
        $scope.activities.splice(position, 1);
      }, function(errors) {
        $scope.errors = errors.data;
      });
    };

    $scope.showActivity = function(activity) {
      activity.details = true;
      activity.editing = false;
    };

    $scope.hideActivity = function(activity) {
      activity.details = false;
    };

    $scope.editActivity = function(activity) {
      activity.editing = true;
      activity.details = false;
    };

    $scope.updateActivity = function(activity) {
      activity.$update(function() {
        activity.editing = false;
      }, function(errors) {
        $scope.errors = errors.data;
      });
    };

    $scope.clearErrors = function() {
      $scope.errors = null;
    };
}]);