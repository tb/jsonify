# ==========================================================================
# UPDATE LOG
# ==========================================================================
# 10/12/2014 - WonSong (http://wys.io)
# - Created initial file.
# ==========================================================================

'use strict'

###
@module {Controller} CollapseCtrl
###
angular.module 'jsonifyApp'
.controller 'CollapseCtrl', ($scope) ->
  $scope.isCollapsed = true

  $scope.$on 'on-collapse-all', () ->
    $scope.isCollapsed = true
    return

  $scope.$on 'on-expand-all', () ->
    $scope.isCollapsed = false
    return

  return