# ==========================================================================
# UPDATE LOG
# ==========================================================================
# 10/11/2014 - WonSong (http://wys.io)
# - Created initial file.
# - Added formatJSON(), minifyJSON(), validateJSON() methods
# --------------------------------------------------------------------------
# 10/24/2014 - WonSong (http://wys.io)
# - JSONUtil has been renamed to JSONEditorSVC
# ==========================================================================

'use strict'

###
Provides utility methods for JSON operations used in the jsonify app
@module {Service} JSONEditorSVC
###
angular.module 'jsonifyApp'
.factory 'JSONEditorSVC', () ->

  ###
  Formats and returns {unformatted_json} string
  @method formatJSON
  @param unformatted_json {String} JSON string to format
  @return {String} Formatted JSON string
  ###
  formatJSON: (unformatted_json) ->
    if unformatted_json.length > 0
      return JSON.stringify JSON.parse(unformatted_json), null, 2
    else
      return ''

  ###
  Minifies and returns the {json} string
  @method minifyJSON
  @param json {String} JSON string to minify
  @return {String} minified JSON string
  ###
  minifyJSON: (json) ->
    return json.replace /\s(?!(\b))/g, ''

  ###
  Validates the JSON string
  @method validateJSON
  @param json {String} json string to validate
  @param callback {Function} callback after validating the json string
  ###
  validateJSON: (json, callback) ->
    jsonObj = undefined
    try
      if json.length > 0
      then jsonObj = JSON.parse json
      callback true, null, jsonObj
    catch e
      callback false, e
    return