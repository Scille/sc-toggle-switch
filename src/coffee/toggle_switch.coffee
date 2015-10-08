'use strict'

angular.module('toggle-switch', [])
  .directive 'toggleSwitchDirective', ->
    restrict: 'EA'
    templateUrl: '../html_template/toggle_switch_template.html'
    controller: 'toggleSwitchController'
    require: 'ngModel'
    scope:
      isDisabled: '=?'
      switchSize: '@'
      onLabel: '@'
      offLabel: '@'
      knobLabel: '@'
      ### TODO Select Color
      onLabelColor: '@'
      offLabelColor: '@'
      knobLabelColor: '@'
      ###
    compile: (tElement, tAttrs) ->
      if (angular.isUndefined(tAttrs.isDisabled))
        tAttrs.isDisabled = false

      if (angular.isUndefined(tAttrs.switchSize))
        tAttrs.switchSize = "switch-medium"
      else if (!tAttrs.switchSize.match("^(xsmall|small|medium|large|xlarge)$"))
        console.log("Error: switch-size must xsmall|small|medium|large|xlarge")
        tAttrs.switchSize = "switch-medium"
      else
        tAttrs.switchSize = "switch-" + tAttrs.switchSize

      if (angular.isUndefined(tAttrs.onLabel))
        tAttrs.onLabel = 'On'

      if (angular.isUndefined(tAttrs.offLabel))
        tAttrs.offLabel = 'Off'

      if (angular.isUndefined(tAttrs.knobLabel))
        # NO-BREAK SPACE Unicode Character
        tAttrs.knobLabel = '\u00a0'

      return

    link: (scope, iElement, iAttrs, ngModelCtrl) ->
      # The $formatters pipeline. Convert a real model value into a value our view can use.
      ngModel.$formatters.push (modelValue) ->
        return modelValue

      # The $parsers Pipeline. Converts the $viewValue into the $modelValue.
      ngModel.$parsers.push (viewValue) ->
        return viewValue

      # Updating the UI to reflect $viewValue
      ngModel.$render = ->
        scope.model = ngModel.$viewValue

      # Updating $viewValue when the UI changes
      scope.toggle = ->
        scope.model = scope.updateModel()
        ngModel.$setViewValue(scope.model);

      return


  .controller 'toggleSwitchController', ($scope) ->
    $scope.$watch 'model', (value, old_value) ->
      if (value? && !old_value?)
        console.log("undef")

    $scope.updateModel = ->
      $scope.model = !$scope.model
      return $scope.model
