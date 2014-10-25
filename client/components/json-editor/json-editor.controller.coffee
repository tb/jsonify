# ==========================================================================
# UPDATE LOG
# ==========================================================================
# 10/24/2014 - WonSong (http://wys.io)
# - Created initial file.
# - JSON Editor related logic has been moved to this file form MainCtrl
# ==========================================================================

'use strict'

###
Controller for the JSON Editor Partial
@module {Controller} JSONEditorCtrl
@param  $scope {Object}
@param JSONEditorSVC {Object} JSON Editor service
@return {Object}
###
angular.module 'jsonifyApp'
.controller 'JSONEditorCtrl', ($scope, JSONEditorSVC) ->

  editorInstance = undefined
  $scope.hasChanged = false

  ###
  Initializes JSONEditorCtrl
  @method initialize
  @private
  ###
  initialize = () ->
    $scope.model.editorOptions =
      lineWrapping: false
      matchBrackets: true
      autoCloseBrackets: true
      mode: "application/json"
      lineNumbers: true
      theme: 'mdn-like'
      gutters: ['CodeMirror-lint-markers', 'CodeMirror-linenumbers', "CodeMirror-foldgutter"]
      foldGutter: true
      lint: true

    $scope.$parent.$watch 'model.JSON', onJSONChanged

  ###
  Handler for JSON change event
  @method onJSONChanged
  @private
  ###
  onJSONChanged = (new_value) ->
    $scope.hasChanged = true

    JSONEditorSVC.validateJSON new_value, (is_valid, error, json_obj) ->
      $scope.model.isValid = is_valid
      $scope.model.JSONObject = json_obj
      $scope.model.errorMessage = if error then error.name
      return
    return

  ###
  Formats the current JSON entered by the user
  @method autoFormat
  @private
  ###
  autoFormat = () ->
    if $scope.hasChanged is false or $scope.model.options.autoFormat is false then return

    JSONEditorSVC.validateJSON $scope.model.JSON, (is_valid) ->
      if is_valid
        $scope.hasChanged = false
        editorInstance.setValue JSONEditorSVC.formatJSON $scope.model.JSON
    return


  ###
  On click on the auto format checkbox, if autoFormat option is set to true, trigger auto format
  @method onAutoFormatChange
  ###
  onAutoFormatChange = () ->
    autoFormat() if $scope.model.options.autoFormat is true

  ###

  @method onCodeWrapChange
  ###
  onCodeWrapChange = () ->
    editorInstance.setOption('lineWrapping', $scope.model.options.codeWrap);

  ###
  On click on the minify button, trigger the JSONEditorSVCs.minify(object) method and reset the current
  JSON string and turn auto format off.
  @method onMinifyRequest
  ###
  onMinifyRequest = () ->
    JSONEditorSVC.validateJSON $scope.model.JSON, (isValid) ->
      $scope.model.options.autoFormat = false;
      $scope.model.JSON = JSONEditorSVC.minifyJSON $scope.model.JSON if isValid is true
      return
    return

  ###
  On click on the format button, set the autoFormat option to true and run the onAutoFormatChange
  function.
  @method onFormatRequest
  ###
  onFormatRequest = () ->
    JSONEditorSVC.validateJSON $scope.model.JSON, (isValid) ->
      $scope.model.JSON = JSONEditorSVC.formatJSON $scope.model.JSON if isValid is true
      return
    return

  ###
  Callback when the CodeMirror is initialized. Stores the {_editor} object to editorInstance variable.
  By default autoFormat should be enabled. This method registers autoFormat event on focus out
  @method onCodemirrorLoader
  @param _editor {Object} Initialized CodeMirror object
  @private
  ###
  onCodemirrorLoaded = (_editor) ->
    editorInstance = _editor
    editorInstance.on 'blur', autoFormat
    return

  initialize()

  $scope.onCodemirrorLoaded = onCodemirrorLoaded
  $scope.onAutoFormatChange = onAutoFormatChange;
  $scope.onMinifyRequest = onMinifyRequest;
  $scope.onFormatRequest = onFormatRequest;
  $scope.onCodeWrapTrigger = onCodeWrapChange;
