# ==========================================================================
# UPDATE LOG
# ==========================================================================
# 10/11/2014 - WonSong (http://wys.io)
# - Created initial file.
# ==========================================================================

'use strict'

###
Controller for the main page
@module {Controller} ObjectViewerCtrl
###
angular.module 'jsonifyApp'
.controller 'ObjectViewerCtrl', ($scope, ObjectViewer) ->

  $scope.isObject = ObjectViewer.isObject
  $scope.isArray = ObjectViewer.isArray
  $scope.isFunction = ObjectViewer.isFunction
  $scope.getName = ObjectViewer.getName