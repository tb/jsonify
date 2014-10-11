'use strict'

###
Controller for the main page

@module {Controller} MainCtrl
@param  $scope {Object}
@param JSONValidator {Object} JSON Validator service
@return {Object}
###
angular.module 'jsonifyApp'
.controller 'MainCtrl', ($scope, JSONUtil) ->

  editorInstance = undefined

  initialize = () ->
    $scope.myJSON = ''

    $scope.editorOptions = {
      lineWrapping: false
      matchBrackets: true
      autoCloseBrackets: true
      mode: "application/json"
      lineNumbers: true
      theme: 'mdn-like'
    }

    $scope.$watch 'myJSON', onJSONChanged
    return

  onJSONChanged = () ->
    JSONUtil.isValidJSON $scope.myJSON, (is_valid, error, json_obj) ->
      $scope.isValid = is_valid
      $scope.myJSONObj = json_obj
      $scope.errorMessage = if error then error.name
      return
    return

  onCodemirrorLoaded = (_editor) ->
    editorInstance = _editor
    editorInstance.on 'blur', autoFormat
    return

  autoFormat = () ->
    formattedJSON = JSONUtil.formatJSON($scope.myJSON);
    editorInstance.setValue(formattedJSON)
    return

  initialize();

  $scope.onCodemirrorLoaded = onCodemirrorLoaded