# ==========================================================================
# UPDATE LOG
# ==========================================================================
# 10/11/2014 - WonSong (http://wys.io)
# - Created initial file.
# - Added formatJSON(), minifyJSON(), and validateJSON() methods
# ==========================================================================

'use strict'

###
Provides utility methods for JSON operations used in the jsonify app
@module {Service} JSONUtil
###
angular.module 'jsonifyApp'
.factory 'JSONUtil', () ->

  ###
  Formats and returns {unformatted_json} string
  @method formatJSON
  @param unformatted_json {String} JSON string to format
  @return {String} Formatted JSON string
  ###
  formatJSON: (unformatted_json) ->
    return JSON.stringify JSON.parse(unformatted_json), null, 2

  ###
  Minifies and returns the {json} string
  @method minifyJSON
  @param json {String} JSON string to minify
  @return {String} minified JSON string
  ###
  minifyJSON: (json) ->
    return json.replace /\s/g, ''

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