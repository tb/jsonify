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
  $scope.isCollapsed = false