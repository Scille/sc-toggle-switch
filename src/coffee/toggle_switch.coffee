'use strict'

angular.module('sc-toggle-switch', [])
  .run ($templateCache) ->
    $templateCache.put('template', '../html_template/toggle_switch_template.html')
  .directive 'toggleSwitchDirective', ($templateCache) ->
    restrict: 'EA'
    templateUrl: $templateCache.get('template')
    controller: 'toggleSwitchController'
    require: 'ngModel'
    scope:
      isDisabled: '=?'
      isSummarised: '=?'
      isAnimated: '=?'
      switchSize: '@'
      leftLabel: '@'
      rightLabel: '@'
      knobLabel: '@'
      leftLabelColor: '@'
      rightLabelColor: '@'
      knobLabelColor: '@'
      borderColor: '@'

    compile: (tElement, tAttrs) ->
      if (angular.isUndefined(tAttrs.isSummarised))
        tAttrs.isSummarised = 'false'

      if (angular.isUndefined(tAttrs.isDisabled))
        tAttrs.isDisabled = 'false'

      if (angular.isUndefined(tAttrs.isAnimated))
        tAttrs.isAnimated = 'true'

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

    ### Update model when we click on the toggle-switch. ###
    $scope.updateModel = ->
      if (!$scope.isDisabled)
        $scope.model = !$scope.model


    ### Resize labels field Functions ###
    max = null
    $scope.leftLabelStr = null
    $scope.rightLabelStr = null
    $scope.knobLabelStr = null

    $scope.completeWithSpace = (maxLength) ->
      max = Math.max($scope.leftLabel.length, $scope.rightLabel.length, $scope.knobLabel.length)
      $scope.leftLabelStr = angular.copy($scope.leftLabel)
      $scope.rightLabelStr = angular.copy($scope.rightLabel)
      $scope.knobLabelStr = angular.copy($scope.knobLabel)

      if ($scope.leftLabel.length == max)
        while ($scope.rightLabelStr.length < max)
          $scope.rightLabelStr = '\u00a0' + $scope.rightLabelStr + '\u00a0'

        while ($scope.knobLabelStr.length < max)
          $scope.knobLabelStr = '\u00a0' + $scope.knobLabelStr + '\u00a0'

      else if ($scope.rightLabel.length == max)
        while ($scope.leftLabelStr.length < max)
          $scope.leftLabelStr = '\u00a0' + $scope.leftLabelStr + '\u00a0'

        while ($scope.knobLabelStr.length < max)
          $scope.knobLabelStr = '\u00a0' + $scope.knobLabelStr + '\u00a0'

      else
        while ($scope.leftLabelStr.length < max)
          $scope.leftLabelStr = '\u00a0' + $scope.leftLabelStr + '\u00a0'

        while ($scope.rightLabelStr.length < max)
          $scope.rightLabelStr = '\u00a0' + $scope.rightLabelStr + '\u00a0'


    $scope.$watch 'leftLabel', ->
      $scope.completeWithSpace()

    $scope.$watch 'rightLabel', ->
      $scope.completeWithSpace()

    $scope.$watch 'knobLabel', ->
      $scope.completeWithSpace()
