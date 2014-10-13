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
  $scope.getTypeName = ObjectViewer.getTypeName
  $scope.getValueCount = ObjectViewer.getValueCount
  $scope.getTypeAndCount = (obj) ->
    if (ObjectViewer.getTypeName obj) is 'Array'
      return '[' + (ObjectViewer.getValueCount obj) + ']'
    else if (ObjectViewer.getTypeName obj) is 'Object'
      return '{' + (ObjectViewer.getValueCount obj) + '}'
    else
      return ''

  $scope.expandAll = () ->
    $scope.$broadcast 'on-expand-all'
    return

  $scope.collapseAll = () ->
    $scope.$broadcast 'on-collapse-all'
    return
