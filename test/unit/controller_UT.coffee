'use strict'

localStorage.clear()

describe 'Controllers ::', ->

  # Load the module, which contains the directive
  beforeEach(module('sc-toggle-switch'))


  # Store references to $controller, so it is available to all tests in this describe block
  describe 'toggleSwitchController\n', ->
    $controller = undefined

    beforeEach inject((_$controller_) ->
      # The injector unwraps the underscores (_) from around the parameter names when matching
      $controller = _$controller_
    )

    ### TEST about toggleSwitchController ###
    ### TEST 01 ###
    it 'Should be defined', ->
      $scope = {}
      controller = $controller('toggleSwitchController', $scope: $scope)
      expect(controller).toBeDefined();


    ### TESTS about $scope.updateModel ###
    describe '$scope.updateModel: ', ->
      $scope = undefined
      controller = undefined

      beforeEach ->
        $scope = {}
        controller = $controller('toggleSwitchController', $scope: $scope)


      ### TEST 02 ###
      it 'sets the strength to "strong" if the password length is >8 chars', ->
        $scope.password = 'longerthaneightchars'
        $scope.grade()
        expect($scope.strength).toEqual 'strong'
