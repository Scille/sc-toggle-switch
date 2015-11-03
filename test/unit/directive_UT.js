localStorage.clear();

describe('Directives ::', function() {

  function checkAttributes(element, isDisabled, isSummarised, isAnimated, switchSize, leftLabel,
                           rightLabel, knobLabel, leftLabelColor, rightLabelColor,
                           knobLabelColor, borderColor, leftValue, rightValue) {

    // check attribute values using isolateScope
    expect(element.isolateScope().isSummarised).toEqual(isDisabled)
    expect(element.isolateScope().isDisabled).toEqual(isSummarised)
    expect(element.isolateScope().isAnimated).toEqual(isAnimated)
    expect(element.isolateScope().switchSize).toEqual(switchSize)
    expect(element.isolateScope().leftLabel).toEqual(leftLabel)
    expect(element.isolateScope().rightLabel).toEqual(rightLabel)
    expect(element.isolateScope().knobLabel).toEqual(knobLabel)
    expect(element.isolateScope().leftLabelColor).toEqual(leftLabelColor)
    expect(element.isolateScope().rightLabelColor).toEqual(rightLabelColor)
    expect(element.isolateScope().knobLabelColor).toEqual(knobLabelColor)
    expect(element.isolateScope().borderColor).toEqual(borderColor)
    expect(element.isolateScope().leftValue).toEqual(leftValue)
    expect(element.isolateScope().rightValue).toEqual(rightValue)
  }


  // Load the module, which contains the directive
  beforeEach(module('app'));

  // Store references to $rootScope and $compile
  // so they are available to all tests in this describe block
  describe('sc-toggle-switch\n', function() {
    var $compile, $rootScope;

    beforeEach(inject(function (_$compile_, _$rootScope_){
      // The injector unwraps the underscores (_) from around the parameter names when matching
      $compile = _$compile_;
      $rootScope = _$rootScope_;
    }));

    it('1. Replaces the element with the appropriate content (Undef)', function() {
      // Compile a piece of HTML containing the directive
      var element = $compile('<div toggle-switch-directive ng-model="switchModel"></div>')($rootScope);

      // fire all the watches
      $rootScope.$digest();

      // When attributes are undefined
      checkAttributes(element, false, false, true, "switch-medium", "On", "Off", "\u00a0", "blue", "red", "white", "gray", true, false)
    });

    it('2. Replaces the element with the appropriate content (Labels)', function() {
      // Compile a piece of HTML containing the directive
      var element = $compile('<div toggle-switch-directive ng-model="switchModel" left-label="Yes" right-label="No" knob-label="TV"></div>')($rootScope);

      // fire all the watches
      $rootScope.$digest();

      // When attributes are undefined
      checkAttributes(element, false, false, true, "switch-medium", "Yes", "No", "TV", "blue", "red", "white", "gray", true, false)
    });

    it('3. Replaces the element with the appropriate content (Sizes)', function() {
      // Compile a piece of HTML containing the directive
      var elementXS = $compile('<div toggle-switch-directive switch-size="xsmall" ng-model="switchModel"></div>')($rootScope);
      var elementS = $compile('<div toggle-switch-directive switch-size="small" ng-model="switchModel"></div>')($rootScope);
      var elementM = $compile('<div toggle-switch-directive switch-size="medium" ng-model="switchModel"></div>')($rootScope);
      var elementL = $compile('<div toggle-switch-directive switch-size="large" ng-model="switchModel"></div>')($rootScope);
      var elementXL = $compile('<div toggle-switch-directive switch-size="xlarge" ng-model="switchModel"></div>')($rootScope);

      // fire all the watches
      $rootScope.$digest();

      // When attributes are undefined
      checkAttributes(elementXS, false, false, true, "switch-xsmall", "On", "Off", "\u00a0", "blue", "red", "white", "gray", true, false)
      checkAttributes(elementS, false, false, true, "switch-small", "On", "Off", "\u00a0", "blue", "red", "white", "gray", true, false)
      checkAttributes(elementM, false, false, true, "switch-medium", "On", "Off", "\u00a0", "blue", "red", "white", "gray", true, false)
      checkAttributes(elementL, false, false, true, "switch-large", "On", "Off", "\u00a0", "blue", "red", "white", "gray", true, false)
      checkAttributes(elementXL, false, false, true, "switch-xlarge", "On", "Off", "\u00a0", "blue", "red", "white", "gray", true, false)
    });

    it('4. Replaces the element with the appropriate content (Colors)', function() {
      // Compile a piece of HTML containing the directive
      var element = $compile('<div toggle-switch-directive ng-model="switchModel" border-color="blue" left-label-color="red" knob-label-color="black" right-label-color="green"></div>')($rootScope);

      // fire all the watches
      $rootScope.$digest();

      // When attributes are undefined
      checkAttributes(element, false, false, true, "switch-medium", "On", "Off", "\u00a0", "red", "green", "black", "blue", true, false)
    });
  });
});
