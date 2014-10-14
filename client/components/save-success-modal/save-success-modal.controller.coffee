# ==========================================================================
# UPDATE LOG
# ==========================================================================
# 10/13/2014 - WonSong (http://wys.io)
# - Created initial file.
# ==========================================================================

'use strict'


angular.module 'jsonifyApp'
.controller 'SaveSuccessModalCtrl', ($scope, jsonId, dismiss) ->

  $scope.jsonId = jsonId
  $scope.close = () ->
    dismiss()