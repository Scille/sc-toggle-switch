(function() {
  'use strict';
  angular.module('toggle-switch', []).directive('toggleSwitchDirective', function() {
    return {
      restrict: 'EA',
      templateUrl: '../html_template/toggle_switch_template.html',
      controller: 'toggleSwitchController',
      require: 'ngModel',
      scope: {
        isDisabled: '=?',
        isSummarised: '=?',
        isAnimated: '=?',
        switchSize: '@',
        leftLabel: '@',
        rightLabel: '@',
        knobLabel: '@',
        leftLabelColor: '@',
        rightLabelColor: '@',
        knobLabelColor: '@',
        borderColor: '@'
      },
      compile: function(tElement, tAttrs) {
        var postLink;
        if (angular.isUndefined(tAttrs.isSummarised)) {
          tAttrs.isSummarised = 'false';
        }
        if (angular.isUndefined(tAttrs.isDisabled)) {
          tAttrs.isDisabled = 'false';
        }
        if (angular.isUndefined(tAttrs.isAnimated)) {
          tAttrs.isAnimated = 'true';
        }
        if (angular.isUndefined(tAttrs.switchSize)) {
          tAttrs.switchSize = "switch-medium";
        } else if (!tAttrs.switchSize.match("^(xsmall|small|medium|large|xlarge)$")) {
          console.log("Error: switch-size must xsmall|small|medium|large|xlarge");
          tAttrs.switchSize = "switch-medium";
        } else {
          tAttrs.switchSize = "switch-" + tAttrs.switchSize;
        }
        if (angular.isUndefined(tAttrs.leftLabel)) {
          tAttrs.leftLabel = 'On';
        }
        if (angular.isUndefined(tAttrs.rightLabel)) {
          tAttrs.rightLabel = 'Off';
        }
        if (angular.isUndefined(tAttrs.knobLabel)) {
          tAttrs.knobLabel = '\u00a0';
        }
        if (angular.isUndefined(tAttrs.leftLabelColor)) {
          tAttrs.leftLabelColor = 'blue';
        }
        if (angular.isUndefined(tAttrs.rightLabelColor)) {
          tAttrs.rightLabelColor = 'red';
        }
        if (angular.isUndefined(tAttrs.knobLabelColor)) {
          tAttrs.knobLabelColor = 'white';
        }
        if (angular.isUndefined(tAttrs.borderColor)) {
          tAttrs.borderColor = 'gray';
        }
        return postLink = function(scope, iElement, iAttrs, ngModelCtrl) {
          ngModelCtrl.$formatters.push(function(modelValue) {
            return modelValue;
          });
          ngModelCtrl.$parsers.push(function(viewValue) {
            return viewValue;
          });
          ngModelCtrl.$render = function() {
            return scope.model = ngModelCtrl.$viewValue;
          };
          return scope.$watch('model', function(value) {
            if ((value != null)) {
              if (value) {
                scope.switchStatus = "switch-on";
              } else {
                scope.switchStatus = "switch-off";
              }
              return ngModelCtrl.$setViewValue(scope.model);
            } else {
              return scope.switchStatus = "switch-undef";
            }
          });
        };
      }
    };
  }).controller('toggleSwitchController', function($scope) {

    /* Update model when we click on the toggle-switch. */
    var max;
    $scope.updateModel = function() {
      if (!$scope.isDisabled) {
        return $scope.model = !$scope.model;
      }
    };

    /* Resize labels field Functions */
    max = null;
    $scope.leftLabelStr = null;
    $scope.rightLabelStr = null;
    $scope.knobLabelStr = null;
    $scope.completeWithSpace = function(maxLength) {
      var results, results1, results2;
      max = Math.max($scope.leftLabel.length, $scope.rightLabel.length, $scope.knobLabel.length);
      $scope.leftLabelStr = angular.copy($scope.leftLabel);
      $scope.rightLabelStr = angular.copy($scope.rightLabel);
      $scope.knobLabelStr = angular.copy($scope.knobLabel);
      if ($scope.leftLabel.length === max) {
        while ($scope.rightLabelStr.length < max) {
          $scope.rightLabelStr = '\u00a0' + $scope.rightLabelStr + '\u00a0';
        }
        results = [];
        while ($scope.knobLabelStr.length < max) {
          results.push($scope.knobLabelStr = '\u00a0' + $scope.knobLabelStr + '\u00a0');
        }
        return results;
      } else if ($scope.rightLabel.length === max) {
        while ($scope.leftLabelStr.length < max) {
          $scope.leftLabelStr = '\u00a0' + $scope.leftLabelStr + '\u00a0';
        }
        results1 = [];
        while ($scope.knobLabelStr.length < max) {
          results1.push($scope.knobLabelStr = '\u00a0' + $scope.knobLabelStr + '\u00a0');
        }
        return results1;
      } else {
        while ($scope.leftLabelStr.length < max) {
          $scope.leftLabelStr = '\u00a0' + $scope.leftLabelStr + '\u00a0';
        }
        results2 = [];
        while ($scope.rightLabelStr.length < max) {
          results2.push($scope.rightLabelStr = '\u00a0' + $scope.rightLabelStr + '\u00a0');
        }
        return results2;
      }
    };
    $scope.$watch('leftLabel', function() {
      return $scope.completeWithSpace();
    });
    $scope.$watch('rightLabel', function() {
      return $scope.completeWithSpace();
    });
    return $scope.$watch('knobLabel', function() {
      return $scope.completeWithSpace();
    });
  });

}).call(this);

//# sourceMappingURL=toggle_switch.js.map