# ==========================================================================
# UPDATE LOG
# ==========================================================================
# 10/11/2014 - WonSong (http://wys.io)
# - Created initial file.
# ==========================================================================

'use strict'

###
Controller for the main page
@module {Controller} MainCtrl
@param  $scope {Object}
@param JSONValidator {Object} JSON Validator service
@return {Object}
###
angular.module 'jsonifyApp'
.controller 'MainCtrl', ($scope, $stateParams, $location, JSONUtil, MainRepository) ->

  ###
  Reference to the CodeMirror Object
  @property editorInstance
  @type {Object}
  @private
  ###
  editorInstance = undefined
  jsonId = undefined

  ###
  Initializes the jsonify main page
  @method initialize
  @private
  ###
  initialize = () ->

    $scope.showJSONMenu = true

    jsonId = $stateParams.jsonId
    if jsonId
      MainRepository.get(jsonId: jsonId).$promise.then((response) ->
        $scope.myJSON = response.json
        return
      ).catch (e) ->
        $location.path '/'
        return
    else
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

  ###
  Handler for JSON change event
  @method onJSONChanged
  @private
  ###
  onJSONChanged = () ->
    JSONUtil.validateJSON $scope.myJSON, (is_valid, error, json_obj) ->
      $scope.isValid = is_valid
      $scope.json_obj = json_obj
      $scope.errorMessage = if error then error.name
      return
    return

  ###
  Callback when the CodeMirror is initialized. Stores the {_editor} object to editorInstance variable.
  Registers autoFormat event on focus out
  @method onCodemirrorLoader
  @param _editor {Object} Initialized CodeMirror object
  @private
  ###
  onCodemirrorLoaded = (_editor) ->
    editorInstance = _editor
    editorInstance.on 'blur', autoFormat
    return

  ###
  Formats the current JSON entered by the user
  @method autoFormat
  @private
  ###
  autoFormat = () ->
    editorInstance.setValue JSONUtil.formatJSON $scope.myJSON
    return

  saveJSON = () ->
    if $scope.isValid is true
      MainRepository.post({json: $scope.myJSON}).$promise.then((response) ->
        $location.url ('/' + response._id)
        return
      ).catch (e) ->
        alert e.status
        return
    else
      alert 'Invalid JSON'

  newJSON = () ->
    MainRepository.post({json: ''}).$promise.then((response) ->
      $location.url ('/' + response._id)
      return
    ).catch (e) ->
      alert e.status
      return

  request = () ->
    alert 'This feature is being developed right now. Please check back later.'

  initialize();

  $scope.onCodemirrorLoaded = onCodemirrorLoaded
  $scope.save = saveJSON
  $scope.new = newJSON
  $scope.request = request;
  $scope.share = request;