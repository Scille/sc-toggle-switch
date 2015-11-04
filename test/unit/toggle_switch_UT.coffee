'use strict'

localStorage.clear()

describe 'Toggle Switch ::', ->

  # Load the module, which contains the directive
  beforeEach(module('sc-toggle-switch'))

  # Store references to $rootScope and $compile, so they are available to all tests in this describe block
  describe 'onClick\n', ->
    $compile = undefined
    $rootScope = undefined

    beforeEach inject((_$compile_, _$rootScope_) ->
      # The injector unwraps the underscores (_) from around the parameter names when matching
      $compile = _$compile_
      $rootScope = _$rootScope_
    )

    ### TESTS toggle switch isDisabled = true ###
    describe 'When toggle switch is disabled :', ->
      scope = undefined
      element = undefined

      getClass = (cssClass, template) ->
        scope = $rootScope.$new()
        element = $compile(template)(scope)
        scope.$apply ->
          scope.isDisabled = true
        element = angular.element(element[0].querySelector(cssClass))

      it 'Status remain at "undefined"', ->
        getClass('.toggle-switch', '<div toggle-switch-directive ng-model="switchModel" is-disabled="isDisabled"></div>')

        # Fire all the watches
        scope.$apply()

        element.triggerHandler('click')
        expect(scope.switchModel).toBeUndefined()

      it 'Status remain at "true"', ->
        getClass('.toggle-switch', '<div toggle-switch-directive ng-model="switchModel" is-disabled="isDisabled"></div>')

        # Fire all the watches
        scope.$apply ->
          scope.switchModel = true

        element.triggerHandler('click')
        expect(scope.switchModel).toEqual(true)

      it 'Status remain at "false"', ->
        getClass('.toggle-switch', '<div toggle-switch-directive ng-model="switchModel" is-disabled="isDisabled"></div>')

        # Fire all the watches
        scope.$apply ->
          scope.switchModel = false

        element.triggerHandler('click')
        expect(scope.switchModel).toEqual(false)

    ### TESTS toggle switch isDisabled = false ###
    describe 'When toggle switch is enabled :', ->
      scope = undefined
      element = undefined

      getClass = (cssClass, template) ->
        scope = $rootScope.$new()
        element = $compile(template)(scope)
        scope.$apply()
        element = angular.element(element[0].querySelector(cssClass))

      it 'Status changes from "undefined" to "true"', ->
        getClass('.toggle-switch', '<div toggle-switch-directive ng-model="switchModel"></div>')

        # Fire all the watches
        scope.$apply()

        element.triggerHandler('click')
        expect(scope.switchModel).toEqual(true)

      it 'Status changes from "true" to "false"', ->
        getClass('.toggle-switch', '<div toggle-switch-directive ng-model="switchModel"></div>')

        # Fire all the watches
        scope.$apply ->
          scope.switchModel = true

        element.triggerHandler('click')
        expect(scope.switchModel).toEqual(false)

      it 'Status changes from "false" to "true"', ->
        getClass('.toggle-switch', '<div toggle-switch-directive ng-model="switchModel"></div>')

        # Fire all the watches
        scope.$apply ->
          scope.switchModel = false

        element.triggerHandler('click')
        expect(scope.switchModel).toEqual(true)

      it 'Status changes from "undefined" to "leftValue"', ->
        getClass('.toggle-switch', '<div toggle-switch-directive ng-model="switchModel" left-value="\'left\'" right-value="\'right\'"></div>')

        # Fire all the watches
        scope.$apply()

        element.triggerHandler('click')
        expect(scope.switchModel).toEqual('left')

      it 'Status changes from "leftValue" to "rightValue"', ->
        getClass('.toggle-switch', '<div toggle-switch-directive ng-model="switchModel" left-value="\'left\'" right-value="\'right\'"></div>')

        # Fire all the watches
        scope.$apply ->
          scope.switchModel = 'left'

        element.triggerHandler('click')
        expect(scope.switchModel).toEqual('right')

      it 'Status changes from "rightValue" to "leftValue"', ->
        getClass('.toggle-switch', '<div toggle-switch-directive ng-model="switchModel" left-value="\'left\'" right-value="\'right\'"></div>')

        # Fire all the watches
        scope.$apply ->
          scope.switchModel = 'right'

        element.triggerHandler('click')
        expect(scope.switchModel).toEqual('left')
