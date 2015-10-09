angular.module('release').run(['$templateCache', function($templateCache) {
  'use strict';

  $templateCache.put('src/html_template/toggle_switch_template.html',
    "<span ng-show=\"!isSummarised\">\n" +
    "  <div class=\"toggle-switch\" ng-style=\"{ 'border-color': borderColor }\" ng-click=\"updateModel()\" ng-class=\"[ switchSize, { 'disabled' : isDisabled } ]\" role=\"switch\" aria-checked=\"{{!!model}}\">\n" +
    "    <div ng-class=\"[ switchStatus, { 'switch-animate' : isAnimated } ]\">\n" +
    "      <span class=\"switch-left\" ng-style=\"{ 'background-color': leftLabelColor }\" ng-bind=\"leftLabelStr\"></span>\n" +
    "      <span class=\"switch-knob\" ng-style=\"{ 'background-color': knobLabelColor }\" ng-bind=\"knobLabelStr\"></span>\n" +
    "      <span class=\"switch-right\" ng-style=\"{ 'background-color': rightLabelColor }\" ng-bind=\"rightLabelStr\"></span>\n" +
    "    </div>\n" +
    "  </div>\n" +
    "</span>\n" +
    "<span ng-show=\"isSummarised\">\n" +
    "  <div class=\"toggle-switch-summarize\" ng-class=\"switchSize\">\n" +
    "    <span class=\"switch-knob\" ng-style=\"{ 'background-color': knobLabelColor }\">{{knobLabel}}</span>\n" +
    "    <span ng-show=\"model != undefined && model\" ng-style=\"{ 'background-color': leftLabelColor }\" class=\"switch-left\">{{leftLabel}}</span>\n" +
    "    <span ng-show=\"model != undefined && !model\" ng-style=\"{ 'background-color': rightLabelColor }\" class=\"switch-right\">{{rightLabel}}</span>\n" +
    "  </div>\n" +
    "</span>\n"
  );

}]);
