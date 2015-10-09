'use strict'

angular.module('toggle-switch', [])
  .directive 'toggleSwitchDirective', ->
    restrict: 'EA'
    templateUrl: '../html_template/toggle_switch_template.html'
    controller: 'toggleSwitchController'
    require: 'ngModel'
    scope:
      isDisabled: '=?'
      isSummarize: '=?'
      isAnimate: '=?'
      switchSize: '@'
      leftLabel: '@'
      rightLabel: '@'
      knobLabel: '@'
      leftLabelColor: '@'
      rightLabelColor: '@'
      knobLabelColor: '@'
      borderColor: '@'

    compile: (tElement, tAttrs) ->
      if (angular.isUndefined(tAttrs.isSummarize))
        tAttrs.isSummarize = 'false'

      if (angular.isUndefined(tAttrs.isDisabled))
        tAttrs.isDisabled = 'false'

      if (angular.isUndefined(tAttrs.isAnimate))
        tAttrs.isAnimate = 'true'

      if (angular.isUndefined(tAttrs.switchSize))
        tAttrs.switchSize = "switch-medium"
      else if (!tAttrs.switchSize.match("^(xsmall|small|medium|large|xlarge)$"))
        console.log("Error: switch-size must xsmall|small|medium|large|xlarge")
        tAttrs.switchSize = "switch-medium"
      else
        tAttrs.switchSize = "switch-" + tAttrs.switchSize

      if (angular.isUndefined(tAttrs.leftLabel))
        tAttrs.leftLabel = 'On'

      if (angular.isUndefined(tAttrs.rightLabel))
        tAttrs.rightLabel = 'Off'

      if (angular.isUndefined(tAttrs.knobLabel))
        # NO-BREAK SPACE Unicode Character
        tAttrs.knobLabel = '\u00a0'

      if (angular.isUndefined(tAttrs.leftLabelColor))
        tAttrs.leftLabelColor = 'blue'

      if (angular.isUndefined(tAttrs.rightLabelColor))
        tAttrs.rightLabelColor = 'red'

      if (angular.isUndefined(tAttrs.knobLabelColor))
        tAttrs.knobLabelColor = 'white'

      if (angular.isUndefined(tAttrs.borderColor))
        tAttrs.borderColor = 'gray'


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
      if (!$scope.isDisabled)
        $scope.model = !$scope.model
