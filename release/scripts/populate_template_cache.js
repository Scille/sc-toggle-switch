angular.module('stcs-templates', []).run(['$templateCache', function($templateCache) {
  "use strict";
  $templateCache.put("src/html_template/toggle_switch_template.html",
    "<span ng-show=!isSummarised><div class=toggle-switch ng-style=\"{ 'border-color': borderColor }\" ng-click=updateModel() ng-class=\"[ switchSize, { 'disabled' : isDisabled } ]\" role=switch aria-checked={{!!model}}><div ng-class=\"[ switchStatus, { 'switch-animate' : isAnimated } ]\"><span class=switch-left ng-style=\"{ 'background-color': leftLabelColor }\" ng-bind=leftLabelStr></span> <span class=switch-knob ng-style=\"{ 'background-color': knobLabelColor }\" ng-bind=knobLabelStr></span> <span class=switch-right ng-style=\"{ 'background-color': rightLabelColor }\" ng-bind=rightLabelStr></span></div></div></span> <span ng-show=isSummarised><div class=toggle-switch-summarize ng-class=switchSize><span ng-show=\"model != undefined && model == leftValue\" ng-style=\"{ 'background-color': leftLabelColor }\" class=switch-left>{{leftLabel}}</span> <span ng-show=\"knobLabel.length > 0\" class=switch-knob ng-style=\"{ 'background-color': knobLabelColor }\">{{knobLabel}}</span> <span ng-show=\"model != undefined && model == rightValue\" ng-style=\"{ 'background-color': rightLabelColor }\" class=switch-right>{{rightLabel}}</span></div></span>");
}]);
