'use strict'

angular.module('sc-toggle-switch', ['stcs-templates'])
  .directive 'toggleSwitchDirective', ($templateCache) ->
    restrict: 'EA'
    templateUrl: 'src/html_template/toggle_switch_template.html'
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
      leftValue: '=?'
      rightValue: '=?'
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

      if (angular.isUndefined(tAttrs.leftValue))
        tAttrs.leftValue = 'true'

      if (angular.isUndefined(tAttrs.rightValue))
        tAttrs.rightValue = 'false'


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
          if value?
            if value == scope.leftValue
              scope.switchStatus = "switch-on"
            else
              scope.switchStatus = "switch-off"
            ngModelCtrl.$setViewValue(scope.model)
          else
            scope.switchStatus = "switch-undef"


  .controller 'toggleSwitchController', ($scope) ->

    ### Define localModel to bind model on 'true/false' value ###
    $scope.localModel = undefined

    ### Update model when we click on the toggle-switch. ###
    $scope.updateModel = ->
      if (!$scope.isDisabled)
        ### For first click, if model is already set, we set localModel
            belong to model value ###
        if $scope.localModel == undefined
          if $scope.model == $scope.leftValue
            $scope.localModel = true
          else if $scope.model == $scope.rightValue
            $scope.localModel = false

        $scope.localModel = !$scope.localModel
        # Assume that in localModel, left = true, and right = false
        if $scope.localModel == true
          $scope.model = $scope.leftValue
        else if $scope.localModel == false
          $scope.model = $scope.rightValue
        else
          $scope.model = undefined

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
        if $scope.rightLabelStr
          while ($scope.rightLabelStr.length < max)
            $scope.rightLabelStr = '\u00a0' + $scope.rightLabelStr + '\u00a0'

        if $scope.knobLabelStr
          while ($scope.knobLabelStr.length < max)
            $scope.knobLabelStr = '\u00a0' + $scope.knobLabelStr + '\u00a0'

      else if ($scope.rightLabel.length == max)
        if $scope.leftLabelStr
          while ($scope.leftLabelStr.length < max)
            $scope.leftLabelStr = '\u00a0' + $scope.leftLabelStr + '\u00a0'

        if $scope.knobLabelStr
          while ($scope.knobLabelStr.length < max)
            $scope.knobLabelStr = '\u00a0' + $scope.knobLabelStr + '\u00a0'

      else
        if $scope.leftLabelStr
          while ($scope.leftLabelStr.length < max)
            $scope.leftLabelStr = '\u00a0' + $scope.leftLabelStr + '\u00a0'

        if $scope.rightLabelStr
          while ($scope.rightLabelStr.length < max)
            $scope.rightLabelStr = '\u00a0' + $scope.rightLabelStr + '\u00a0'


    $scope.$watch 'leftLabel', ->
      $scope.completeWithSpace()

    $scope.$watch 'rightLabel', ->
      $scope.completeWithSpace()

    $scope.$watch 'knobLabel', ->
      $scope.completeWithSpace()
