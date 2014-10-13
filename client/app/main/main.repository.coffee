# ==========================================================================
# UPDATE LOG
# ==========================================================================
# 10/12/2014 - WonSong (http://wys.io)
# - Created initial file.
# ==========================================================================

'use strict'

###

###
angular.module 'jsonifyApp'
.factory 'MainRepository', ($resource) ->
  return $resource '/api/json/:jsonId', null, {
    'get': {
      'method': 'get'
    },
    'post': {
      'method': 'post'
    }
  }