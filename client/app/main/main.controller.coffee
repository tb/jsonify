# ==========================================================================
# UPDATE LOG
# ==========================================================================
# 10/11/2014 - WonSong (http://wys.io)
# - Created initial file.
# --------------------------------------------------------------------------
# 10/15/2014 - Won Song (http://wys.io)
# - Added auto format toggle functionality.
# --------------------------------------------------------------------------
# 10/16/2014 - Bill Weithers
# - added minification functionality.
# - found an error when using the editorInstance.setValue method - the
# $scope.myJSON value is not updated when this is used and when the
# contents of the editor is changed when auto focus is off and then
# auto focus is turned back on.
# - will need to style the button correctly.
# --------------------------------------------------------------------------
# 10/24/2014 - Won Song (http://wys.io)
# - JSON Editor logic has been moved to JSONEditorCtrl and JSONEditorSVC
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
.controller 'MainCtrl', ($scope, $stateParams, $modal, $location, MainRepository) ->
  jsonId = undefined

  ###
  Initializes the jsonify main page
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
    $scope.model =
      JSON: ''
      options:
        autoFormat: true
        showJSONMenu: true

    jsonId = $stateParams.jsonId
    if jsonId
      MainRepository.get(jsonId: jsonId).$promise.then((response) ->
        $scope.model.JSON = response.json
        return
      ).catch (e) ->
        $location.path '/'
        return

  saveJSON = () ->
    if $scope.model.isValid is true
      params = if jsonId then {jsonId: jsonId} else null
      MainRepository.post(params, {json: $scope.model.JSON}).$promise.then((response) ->
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

  initialize();

  $scope.save = saveJSON
  $scope.new = newJSON
  $scope.request = request;
  $scope.share = request;
