(function() {
  'use strict';
  angular.module('sc-toggle-switch', ['stcs-templates']).directive('toggleSwitchDirective', function($templateCache) {
    return {
      restrict: 'EA',
      templateUrl: 'src/html_template/toggle_switch_template.html',
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
        leftValue: '=?',
        rightValue: '=?',
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
        if (angular.isUndefined(tAttrs.leftValue)) {
          tAttrs.leftValue = 'true';
        }
        if (angular.isUndefined(tAttrs.rightValue)) {
          tAttrs.rightValue = 'false';
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
            if (value != null) {
              if (value === scope.leftValue) {
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

    /* Define localModel to bind model on 'true/false' value */
    var max;
    $scope.localModel = void 0;

    /* Update model when we click on the toggle-switch. */
    $scope.updateModel = function() {
      if (!$scope.isDisabled) {

        /* For first click, if model is already set, we set localModel
            belong to model value
         */
        if ($scope.localModel === void 0) {
          if ($scope.model === $scope.leftValue) {
            $scope.localModel = true;
          } else if ($scope.model === $scope.rightValue) {
            $scope.localModel = false;
          }
        }
        $scope.localModel = !$scope.localModel;
        if ($scope.localModel === true) {
          return $scope.model = $scope.leftValue;
        } else if ($scope.localModel === false) {
          return $scope.model = $scope.rightValue;
        } else {
          return $scope.model = void 0;
        }
      }
    };

    /* Resize labels field Functions */
    max = null;
    $scope.leftLabelStr = null;
    $scope.rightLabelStr = null;
    $scope.knobLabelStr = null;
    $scope.completeWithSpace = function(maxLength) {
      var results, results1, results2;
      $scope.leftLabelStr = $scope.leftLabel != null ? angular.copy($scope.leftLabel) : '';
      $scope.rightLabelStr = $scope.rightLabel != null ? angular.copy($scope.rightLabel) : '';
      $scope.knobLabelStr = $scope.knobLabel != null ? angular.copy($scope.knobLabel) : '';
      max = Math.max($scope.leftLabelStr.length, $scope.rightLabelStr.length, $scope.knobLabelStr.length);
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
