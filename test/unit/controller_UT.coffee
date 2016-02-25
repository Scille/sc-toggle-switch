'use strict'

localStorage.clear()

describe 'Controllers ::', ->

  # Load the module, which contains the directive
  beforeEach(module('sc-toggle-switch'))

  # Store references to $controller and $rootScope, so they are available to all tests in this describe block
  describe 'scToggleSwitchController\n', ->
    $controller = undefined
    $rootScope = undefined

    beforeEach inject((_$controller_, _$rootScope_) ->
      # The injector unwraps the underscores (_) from around the parameter names when matching
      $controller = _$controller_
      $rootScope = _$rootScope_
    )


    ### TEST about scToggleSwitchController ###
    it 'Should be defined', ->
      scope = $rootScope.$new()
      controller = $controller('scToggleSwitchController', $scope: scope)
      expect(controller).toBeDefined()


    ### TESTS about $scope.updateModel ###
    describe '$scope.updateModel:', ->
      scope = undefined
      controller = undefined

      beforeEach ->
        scope = $rootScope.$new()
        controller = $controller('scToggleSwitchController', $scope: scope)

      it 'Update model value when we click on the toggle-switch', ->
        # init: $scope.localModel = undefined
        expect(scope.localModel).toBeUndefined()

        # first click: $scope.localModel = true
        scope.updateModel()
        expect(scope.localModel).toEqual(true)

        # second click: $scope.localModel = false
        scope.updateModel()
        expect(scope.localModel).toEqual(false)

      it 'Can not update model value when we click on the toggle-switch (isDisabled)', ->
        # init: $scope.localModel = undefined
        expect(scope.localModel).toBeUndefined()

        # set toggle-switch as disabled
        scope.isDisabled = true

        # Do nothing on click: $scope.localModel = undefined
        scope.updateModel()
        expect(scope.localModel).toBeUndefined()


    ### TESTS about $scope.completeWithSpace ###
    describe '$scope.completeWithSpace:', ->
      scope = undefined
      controller = undefined

      beforeEach ->
        scope = $rootScope.$new()
        controller = $controller('scToggleSwitchController', $scope: scope)

      it 'Complete leftLabelStr and rightLabelStr with spaces', ->
        # initialisation
        expect(scope.leftLabelStr).toBe(null)
        expect(scope.rightLabelStr).toBe(null)
        expect(scope.knobLabelStr).toBe(null)

        scope.leftLabel = 'left'
        scope.rightLabel = 'right'
        scope.knobLabel = 'knobLabel'
        scope.completeWithSpace()

        expect(scope.leftLabelStr).toEqual('\u00a0\u00a0\u00a0' + 'left' + '\u00a0\u00a0\u00a0')
        expect(scope.rightLabelStr).toEqual('\u00a0\u00a0' + 'right' + '\u00a0\u00a0')
        expect(scope.knobLabelStr).toEqual('knobLabel')

      it 'Complete leftLabelStr and rightLabelStr with spaces (when leftLabel and rightLabel are undefined)', ->
        # initialisation
        expect(scope.leftLabelStr).toBe(null)
        expect(scope.rightLabelStr).toBe(null)
        expect(scope.knobLabelStr).toBe(null)

        scope.knobLabel = 'knob'
        scope.completeWithSpace()

        expect(scope.leftLabelStr).toEqual('\u00a0\u00a0\u00a0\u00a0')
        expect(scope.rightLabelStr).toEqual('\u00a0\u00a0\u00a0\u00a0')
        expect(scope.knobLabelStr).toEqual('knob')

      it 'Complete rightLabelStr and knobLabelStr with spaces', ->
        # initialisation
        expect(scope.leftLabelStr).toBe(null)
        expect(scope.rightLabelStr).toBe(null)
        expect(scope.knobLabelStr).toBe(null)

        scope.leftLabel = 'leftLabel'
        scope.rightLabel = 'right'
        scope.knobLabel = 'knob'
        scope.completeWithSpace()

        expect(scope.leftLabelStr).toEqual('leftLabel')
        expect(scope.rightLabelStr).toEqual('\u00a0\u00a0' + 'right' + '\u00a0\u00a0')
        expect(scope.knobLabelStr).toEqual('\u00a0\u00a0\u00a0' + 'knob' + '\u00a0\u00a0\u00a0')

      it 'Complete rightLabelStr and knobLabelStr with spaces (when rightLabel and knobLabel are undefined)', ->
        # initialisation
        expect(scope.leftLabelStr).toBe(null)
        expect(scope.rightLabelStr).toBe(null)
        expect(scope.knobLabelStr).toBe(null)

        scope.leftLabel = 'left'
        scope.completeWithSpace()

        expect(scope.leftLabelStr).toEqual('left')
        expect(scope.rightLabelStr).toEqual('\u00a0\u00a0\u00a0\u00a0')
        expect(scope.knobLabelStr).toEqual('\u00a0\u00a0\u00a0\u00a0')

      it 'Complete leftLabelStr and knobLabelStr with spaces', ->
        # initialisation
        expect(scope.leftLabelStr).toBe(null)
        expect(scope.rightLabelStr).toBe(null)
        expect(scope.knobLabelStr).toBe(null)

        scope.leftLabel = 'left'
        scope.rightLabel = 'rightLabel'
        scope.knobLabel = 'knob'
        scope.completeWithSpace()

        expect(scope.leftLabelStr).toEqual('\u00a0\u00a0\u00a0' + 'left' + '\u00a0\u00a0\u00a0')
        expect(scope.rightLabelStr).toEqual('rightLabel')
        expect(scope.knobLabelStr).toEqual('\u00a0\u00a0\u00a0' + 'knob' + '\u00a0\u00a0\u00a0')

      it 'Complete leftLabelStr and knobLabelStr with spaces (when leftLabel and knobLabel are undefined)', ->
        # initialisation
        expect(scope.leftLabelStr).toBe(null)
        expect(scope.rightLabelStr).toBe(null)
        expect(scope.knobLabelStr).toBe(null)

        scope.rightLabel = 'right'
        scope.completeWithSpace()

        expect(scope.leftLabelStr).toEqual('\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0')
        expect(scope.rightLabelStr).toEqual('right')
        expect(scope.knobLabelStr).toEqual('\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0')
