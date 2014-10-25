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
.controller 'ObjectViewerCtrl', ($scope, ObjectViewerSVC) ->

  $scope.isObject = ObjectViewerSVC.isObject
  $scope.isArray = ObjectViewerSVC.isArray
  $scope.isFunction = ObjectViewerSVC.isFunction
  $scope.getTypeName = ObjectViewerSVC.getTypeName
  $scope.getValueCount = ObjectViewerSVC.getValueCount
  $scope.getTypeAndCount = (obj) ->
    if (ObjectViewerSVC.getTypeName obj) is 'Array'
      return '[' + (ObjectViewerSVC.getValueCount obj) + ']'
    else if (ObjectViewerSVC.getTypeName obj) is 'Object'
      return '{' + (ObjectViewerSVC.getValueCount obj) + '}'
    else
      return ''

  $scope.expandAll = () ->
    $scope.$broadcast 'on-expand-all'
    return

  $scope.collapseAll = () ->
    $scope.$broadcast 'on-collapse-all'
    return
