'use strict'

angular.module 'jsonifyApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'doc',
    url: '/doc'
    templateUrl: 'app/doc/doc.html'
