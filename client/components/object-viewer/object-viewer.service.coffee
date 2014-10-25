# ==========================================================================
# UPDATE LOG
# ==========================================================================
# 10/11/2014 - Won Song (http://wys.io)
# - Created initial file.
# --------------------------------------------------------------------------
# 10/24/2014 - Won Song (http://wys.io)
# - ObjectViewer has been renamed to ObjectViewerSVC
# ==========================================================================

'use strict'

###
@module {Service} ObjectViewerSVC
###
angular.module 'jsonifyApp'
.factory 'ObjectViewerSVC', () ->

  getObjectKeyCount = (obj) ->
    count = 0
    for key of obj
      count++  if obj.hasOwnProperty(key) and key.indexOf("$$") is -1
    return count

  toString = Object.prototype.toString

  isObject: (obj) ->
    return obj == (Object obj)

  isArray: (obj) ->
    return (toString.call obj) == '[object Array]'

  isFunction: (obj) ->
    return (toString.call obj) == '[object Function]'

  getValueCount: (obj) ->
    name = this.getTypeName obj
    if name is 'Array'
      return obj.length
    else if name is 'Object'
      return getObjectKeyCount obj
    else
      return name

  ###
  @method getName
  @param obj {Object} Object to get type name
  @return {String} Type name in string
  ###
  getTypeName: (obj) ->
    name = undefined
    if obj is null
      name = '[object Null]'
    else
      name = toString.call obj
    return (name.replace '[object ', '').replace ']', ''