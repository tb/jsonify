# ==========================================================================
# UPDATE LOG
# ==========================================================================
# 10/11/2014 - Won Song (http://wys.io)
# - Created initial file.
# --------------------------------------------------------------------------
# 10/15/2014 - Won Song (http://wys.io)
# - Added auto format toggle functionality.
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
  Initializes the jsonify main pag
  @method initialize
  @private
  ###
  initialize = () ->

    ###
    ViewModel containing important data objects and options objects used in jsonify.
    All scope objects that are not in this model object will be moved here in the near future.
    @property model
    @type {Object}
    ###
    $scope.model = {
      options:
        autoFormat: true
    }

    $scope.showJSONMenu = true
    $scope.hasChanged = false

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
      gutters: ['CodeMirror-lint-markers', 'CodeMirror-linenumbers', "CodeMirror-foldgutter"]
      foldGutter: true
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
  By default autoFormat should be enabled. This method registers autoFormat event on focus out
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
    if $scope.hasChanged is false or $scope.model.options.autoFormat is false then return

    JSONUtil.validateJSON $scope.myJSON, (is_valid) ->
      if is_valid
        $scope.hasChanged = false
        editorInstance.setValue JSONUtil.formatJSON $scope.myJSON
    return

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

  ###
  On click on the auto format checkbox, if autoFormat option is set to true, trigger auto format
  @method onAutoFormatChange
  ###
  onAutoFormatChange = () ->
    autoFormat() if $scope.model.options.autoFormat is true

  initialize();

  $scope.onCodemirrorLoaded = onCodemirrorLoaded
  $scope.save = saveJSON
  $scope.new = newJSON
  $scope.request = request;
  $scope.share = request;
  $scope.onAutoFormatChange = onAutoFormatChange;
