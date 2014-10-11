'use strict'

angular.module 'jsonifyApp'
.factory 'JSONUtil', () ->
  formatJSON: (unformatted_json) ->
    return JSON.stringify JSON.parse(unformatted_json), null, 2

  minifyJSON: (json) ->
    return json.replace /\s/g, ''

  isValidJSON: (json, callback) ->
    jsonObj = undefined

    try
      if json.length > 0
      then jsonObj = JSON.parse json
      callback true, null, jsonObj
    catch e
      callback false, e