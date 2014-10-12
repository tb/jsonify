# ==========================================================================
# UPDATE LOG
# ==========================================================================
# 10/11/2014 - WonSong (http://wys.io)
# - Created initial file.
# - Added formatJSON(), minifyJSON(), isValidJSON(), and convertJSON() methods
# ==========================================================================

'use strict'

###
@module {Service} ObjectViewer
###
angular.module 'jsonifyApp'
.factory 'ObjectViewer', () ->

  toString = Object.prototype.toString

  isObject: (obj) ->
    return obj == Object(obj)

  isArray: (obj) ->
    return toString.call(obj) == '[object Array]'

  isFunction: (obj) ->
    return toString.call obj == '[object Function]'