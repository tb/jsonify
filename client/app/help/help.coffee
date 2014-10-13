'use strict'

angular.module 'jsonifyApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'help',
    url: '/help'
    templateUrl: 'app/help/help.html'
