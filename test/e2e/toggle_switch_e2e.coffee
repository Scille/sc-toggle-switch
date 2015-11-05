'use strict'

describe 'Toggle Switch Demo App ::', ->

  beforeEach ->
    browser.get('http://localhost:9000/')

  it 'Should have a title', ->
    expect(browser.getTitle()).toEqual('Toggle Switch Example')
