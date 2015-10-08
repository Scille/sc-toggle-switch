'use strict'

angular.module('toggle-switch', [])
  .directive 'toggleSwitchDirective', ->
    restrict: 'EA'
    templateUrl: '../html_template/toggle_switch_template.html'
    controller: 'toggleSwitchController'
    require: 'ngModel'
    scope:
      showAsButton: '=?'
      isDisabled: '=?'
      switchSize: '@'
      switchAnimate: '=?'
      onLabel: '@'
      offLabel: '@'
      knobLabel: '@'
      ### TODO Select Color
      onLabelColor: '@'
      offLabelColor: '@'
      knobLabelColor: '@'
      ###

    compile: (tElement, tAttrs) ->
      if (angular.isUndefined(tAttrs.showAsButton))
        tAttrs.showAsButton = 'false'

      if (angular.isUndefined(tAttrs.isDisabled))
        tAttrs.isDisabled = 'false'

      if (angular.isUndefined(tAttrs.switchSize))
        tAttrs.switchSize = "switch-medium"
      else if (!tAttrs.switchSize.match("^(xsmall|small|medium|large|xlarge)$"))
        console.log("Error: switch-size must xsmall|small|medium|large|xlarge")
        tAttrs.switchSize = "switch-medium"
      else
        tAttrs.switchSize = "switch-" + tAttrs.switchSize

      if (angular.isUndefined(tAttrs.switchAnimate))
        tAttrs.switchAnimate = 'true'

      if (angular.isUndefined(tAttrs.onLabel))
        tAttrs.onLabel = 'On'

      if (angular.isUndefined(tAttrs.offLabel))
        tAttrs.offLabel = 'Off'

      if (angular.isUndefined(tAttrs.knobLabel))
        # NO-BREAK SPACE Unicode Character
        tAttrs.knobLabel = '\u00a0'


      postLink = (scope, iElement, iAttrs, ngModelCtrl) ->
        console.log(scope)
        # The $formatters pipeline. Convert a real model value into a value our view can use.
        ngModelCtrl.$formatters.push (modelValue) ->
          return modelValue

        # The $parsers Pipeline. Converts the $viewValue into the $modelValue.
        ngModelCtrl.$parsers.push (viewValue) ->
          return viewValue

        # Updating the UI to reflect $viewValue
        ngModelCtrl.$render = ->
          scope.model = ngModelCtrl.$viewValue

        # Updating $viewValue when the UI changes
        scope.$watch 'model', (value) ->
          if (value?)
            if (value)
              scope.switchStatus = "switch-on"
            else
              scope.switchStatus = "switch-off"
            ngModelCtrl.$setViewValue(scope.model)
          else
            scope.switchStatus = "switch-undef"


  .controller 'toggleSwitchController', ($scope) ->
    $scope.updateModel = ->
      $scope.model = !$scope.model
