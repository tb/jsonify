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
.controller 'MainCtrl', ($scope, $stateParams, $modal, $location, JSONUtil, MainRepository) ->

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
    $scope.hasChanged = false
    $scope.doAutoFormat = false;

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
      gutters: ['CodeMirror-lint-markers']
      lint: true
    }

    $scope.$watch 'myJSON', onJSONChanged
    return

  ###
  Handler for JSON change event
  @method onJSONChanged
  @private
  ###
  onJSONChanged = () ->
    $scope.hasChanged = true

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
    if $scope.doAutoFormat is false then return
    if $scope.hasChanged is false then return

    JSONUtil.validateJSON $scope.myJSON, (is_valid) ->
      if is_valid
        $scope.hasChanged = false
        $scope.myJSON = JSONUtil.formatJSON $scope.myJSON
    return
    true

  saveJSON = () ->
    if $scope.isValid is true
      params = if jsonId then {jsonId: jsonId} else null
      MainRepository.post(params, {json: $scope.myJSON}).$promise.then((response) ->
        $location.url ('/' + response._id)
        showSuccessModal response._id
        return
      ).catch (e) ->
        alert e.status
        return
    else
      alert 'Invalid JSON'

  newJSON = () ->
    MainRepository.post({json: ''}).$promise.then((response) ->
      $location.url ('/' + response._id)
      showSuccessModal response._id
      return
    ).catch (e) ->
      alert e.status
      return

  request = () ->
    alert 'This feature is being developed right now. Please check back later.'

  showSuccessModal = (json_id) ->
    modal = $modal.open({
      templateUrl: 'components/save-success-modal/save-success-modal.html',
      controller: 'SaveSuccessModalCtrl',
      resolve:
        jsonId: () ->
          return json_id
        dismiss: () ->
          return () ->
            modal.dismiss()
    })

  minimizeJSON = () ->
    if $scope.isValid is true
      $scope.myJSON = JSONUtil.minifyJSON $scope.myJSON;
      $scope.doAutoFormat = false;
    true;


  formatJSON = () ->
    if $scope.isValid is true
      $scope.doAutoFormat = true;
      $scope.autoFormat()
    true;
  initialize();

  $scope.onCodemirrorLoaded = onCodemirrorLoaded
  $scope.save = saveJSON
  $scope.new = newJSON
  $scope.request = request;
  $scope.share = request;
  $scope.minimizeJSON = minimizeJSON;
  $scope.autoFormat = autoFormat;
  $scope.formatJSON = formatJSON;