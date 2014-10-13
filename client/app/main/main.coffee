'use strict'

angular.module 'jsonifyApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'main',
    url: '/:jsonId'
    templateUrl: 'app/main/main.html'
    controller: 'MainCtrl'
