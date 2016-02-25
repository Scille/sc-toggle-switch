'use strict'

angular.module('sc-toggle-switch', ['toggle_switchTemplate'])
  .directive 'scToggleSwitchDirective', -> {
    restrict: 'EA'
    templateUrl: 'script/toggle_switch_template.html'
    controller: 'scToggleSwitchController'
    require: 'ngModel'
    scope: {
      isDisabled: '=?'
      isSummarised: '=?'
      isAnimated: '=?'
      switchSize: '@'
      leftLabel: '@'
      rightLabel: '@'
      knobLabel: '@'
      leftLabelColor: '@'
      rightLabelColor: '@'
      leftValue: '=?'
      rightValue: '=?'
      knobLabelColor: '@'
      borderColor: '@'
    }

    compile: (tElement, tAttrs) ->
      if (angular.isUndefined(tAttrs.isSummarised))
        tAttrs.isSummarised = 'false'

      if (angular.isUndefined(tAttrs.isDisabled))
        tAttrs.isDisabled = 'false'

      if (angular.isUndefined(tAttrs.isAnimated))
        tAttrs.isAnimated = 'true'

      if (angular.isUndefined(tAttrs.switchSize))
        tAttrs.switchSize = "switch-medium"
      else if (not tAttrs.switchSize.match("^(xsmall|small|medium|large|xlarge)$"))
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

      if (angular.isUndefined(tAttrs.leftValue))
        tAttrs.leftValue = 'true'

      if (angular.isUndefined(tAttrs.rightValue))
        tAttrs.rightValue = 'false'


      postLink = (scope, iElement, iAttrs, ngModelCtrl) ->
        # The $formatters pipeline. Convert a real model value into a value our
        # view can use.
        ngModelCtrl.$formatters.push (modelValue) ->
          if (modelValue is scope.leftValue)
            return true
          else if (modelValue is scope.rightValue)
            return false

        # The $parsers Pipeline. Converts the $viewValue into the $modelValue.
        ngModelCtrl.$parsers.push (viewValue) ->
          return if (viewValue) then angular.copy(scope.leftValue) else angular.copy(scope.rightValue)

        # Updating the UI to reflect $viewValue
        ngModelCtrl.$render = ->
          scope.localModel = ngModelCtrl.$viewValue

        # Updating $viewValue when the UI changes
        scope.$watch 'localModel', (value) ->
          if value?
            if value
              scope.switchStatus = "switch-on"
            else
              scope.switchStatus = "switch-off"
          else
            scope.switchStatus = "switch-undef"
          ngModelCtrl.$setViewValue(value)

  }
  .controller 'scToggleSwitchController', ($scope) ->

    ### Define localModel to bind model on 'true/false' value ###
    $scope.localModel = undefined

    ### Update model when we click on the toggle-switch. ###
    $scope.updateModel = ->
      if (not $scope.isDisabled)
        $scope.localModel = not $scope.localModel

    ### Resize labels field Functions ###
    max = null
    $scope.leftLabelStr = null
    $scope.rightLabelStr = null
    $scope.knobLabelStr = null

    $scope.completeWithSpace = ->
      $scope.leftLabelStr = if $scope.leftLabel? then angular.copy($scope.leftLabel) else ''
      $scope.rightLabelStr = if $scope.rightLabel? then angular.copy($scope.rightLabel) else ''
      $scope.knobLabelStr = if $scope.knobLabel? then angular.copy($scope.knobLabel) else ''
      max = Math.max($scope.leftLabelStr.length, $scope.rightLabelStr.length, $scope.knobLabelStr.length)

      if ($scope.leftLabelStr.length is max)
        while ($scope.rightLabelStr.length < max)
          $scope.rightLabelStr = '\u00a0' + $scope.rightLabelStr + '\u00a0'

        while ($scope.knobLabelStr.length < max)
          $scope.knobLabelStr = '\u00a0' + $scope.knobLabelStr + '\u00a0'

      else if ($scope.rightLabelStr.length is max)
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
