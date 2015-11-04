'use strict'

localStorage.clear()

describe 'Directives ::', ->

  checkAttributes = (element, isDisabled, isSummarised, isAnimated, switchSize, leftLabel, rightLabel, knobLabel, leftLabelColor, rightLabelColor, knobLabelColor, borderColor, leftValue, rightValue) ->
    # check attribute values using isolateScope
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


  # Load the module, which contains the directive
  beforeEach(module('app'))


  # Store references to $rootScope and $compile, so they are available to all tests in this describe block
  describe 'sc-toggle-switch\n', ->
    $compile = undefined
    $rootScope = undefined

    beforeEach inject((_$compile_, _$rootScope_) ->
      # The injector unwraps the underscores (_) from around the parameter names when matching
      $compile = _$compile_
      $rootScope = _$rootScope_
    )

    it '1. Replaces the element with the appropriate content (Undef)', ->
      # Compile a piece of HTML containing the directive
      element = $compile('<div toggle-switch-directive ng-model="switchModel"></div>')($rootScope)

      # Fire all the watches
      $rootScope.$digest()

      checkAttributes(element, false, false, true, 'switch-medium', 'On', 'Off', '\u00a0', 'blue', 'red', 'white', 'gray', true, false)


    it '2. Replaces the element with the appropriate content (Labels)', ->
      # Compile a piece of HTML containing the directive
      element = $compile('<div toggle-switch-directive ng-model="switchModel" left-label="Yes" right-label="No" knob-label="TV"></div>')($rootScope)

      # Fire all the watches
      $rootScope.$digest()

      checkAttributes(element, false, false, true, 'switch-medium', 'Yes', 'No', 'TV', 'blue', 'red', 'white', 'gray', true, false)


    it '3. Replaces the element with the appropriate content (Sizes)', ->
      # Compile a piece of HTML containing the directive
      elementXS = $compile('<div toggle-switch-directive switch-size="xsmall" ng-model="switchModel"></div>')($rootScope)
      elementS = $compile('<div toggle-switch-directive switch-size="small" ng-model="switchModel"></div>')($rootScope)
      elementM = $compile('<div toggle-switch-directive switch-size="medium" ng-model="switchModel"></div>')($rootScope)
      elementL = $compile('<div toggle-switch-directive switch-size="large" ng-model="switchModel"></div>')($rootScope)
      elementXL = $compile('<div toggle-switch-directive switch-size="xlarge" ng-model="switchModel"></div>')($rootScope)
      elementError = $compile('<div toggle-switch-directive switch-size="unsized" ng-model="switchModel"></div>')($rootScope)

      # Fire all the watches
      $rootScope.$digest()

      checkAttributes(elementXS, false, false, true, 'switch-xsmall', 'On', 'Off', '\u00a0', 'blue', 'red', 'white', 'gray', true, false)
      checkAttributes(elementS, false, false, true, 'switch-small', 'On', 'Off', '\u00a0', 'blue', 'red', 'white', 'gray', true, false)
      checkAttributes(elementM, false, false, true, 'switch-medium', 'On', 'Off', '\u00a0', 'blue', 'red', 'white', 'gray', true, false)
      checkAttributes(elementL, false, false, true, 'switch-large', 'On', 'Off', '\u00a0', 'blue', 'red', 'white', 'gray', true, false)
      checkAttributes(elementXL, false, false, true, 'switch-xlarge', 'On', 'Off', '\u00a0', 'blue', 'red', 'white', 'gray', true, false)
      checkAttributes(elementError, false, false, true, 'switch-medium', 'On', 'Off', '\u00a0', 'blue', 'red', 'white', 'gray', true, false)


    it '4. Replaces the element with the appropriate content (Colors)', ->
      # Compile a piece of HTML containing the directive
      element = $compile('<div toggle-switch-directive ng-model="switchModel" border-color="blue" left-label-color="red" knob-label-color="black" right-label-color="green"></div>')($rootScope)

      # Fire all the watches
      $rootScope.$digest()

      checkAttributes(element, false, false, true, 'switch-medium', 'On', 'Off', '\u00a0', 'red', 'green', 'black', 'blue', true, false)


    it '5. Replaces the element with the appropriate content (Animate)', ->
      # Compile a piece of HTML containing the directive
      element = $compile('<div toggle-switch-directive ng-model="switchModel" is-animated="false"></div>')($rootScope)

      # Fire all the watches
      $rootScope.$digest()

      checkAttributes(element, false, false, false, 'switch-medium', 'On', 'Off', '\u00a0', 'blue', 'red', 'white', 'gray', true, false)


    it '6. Replaces the element with the appropriate content (Disabled)', ->
      # Compile a piece of HTML containing the directive
      element = $compile('<div toggle-switch-directive ng-model="switchModel" is-disabled="true"></div>')($rootScope)

      # Fire all the watches
      $rootScope.$digest()

      checkAttributes(element, false, true, true, 'switch-medium', 'On', 'Off', '\u00a0', 'blue', 'red', 'white', 'gray', true, false)


    it '7. Replaces the element with the appropriate content (Summarize)', ->
      # Compile a piece of HTML containing the directive
      element = $compile('<div toggle-switch-directive ng-model="switchModel" is-summarised="true"></div>')($rootScope)

      # Fire all the watches
      $rootScope.$digest()

      checkAttributes(element, true, false, true, 'switch-medium', 'On', 'Off', '\u00a0', 'blue', 'red', 'white', 'gray', true, false)


    it '8. Replaces the element with the appropriate content (Labels Value)', ->
      # Compile a piece of HTML containing the directive
      elementBool = $compile('<div toggle-switch-directive ng-model="switchModel" left-value="false" right-value="true"></div>')($rootScope)
      elementStr = $compile('<div toggle-switch-directive ng-model="switchModel" left-value="\'L\'" right-value="\'R\'"></div>')($rootScope)

      # Fire all the watches
      $rootScope.$digest()

      checkAttributes(elementBool, false, false, true, 'switch-medium', 'On', 'Off', '\u00a0', 'blue', 'red', 'white', 'gray', false, true)
      checkAttributes(elementStr, false, false, true, 'switch-medium', 'On', 'Off', '\u00a0', 'blue', 'red', 'white', 'gray', 'L', 'R')
