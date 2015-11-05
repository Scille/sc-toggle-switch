exports.config =
  # Testing framework, jasmine is the default
  framework: 'jasmine2'

  # The webdriver-manager is a helper tool to easily get an instance of a Selenium Server running.
  # Start up a server with ./node_modules/protractor/bin/webdriver-manager start or webdriver-manager start (installed globally)
  # seleniumAddress: 'http://localhost:4444/wd/hub'

  # URL where your app is running, relative URLs are prepending with this URL
  baseUrl: 'http://localhost:9000/'

  # Location of E2E test specs
  specs: [
    'e2e/*.coffee'
  ]

  # Configure multiple browsers to run tests
  # multiCapabilities: [
  #   'browserName': 'firefox'
  #   'browserName': 'chrome'
  #   'browserName': 'safari'
  # ]

  # Configure a single browser
  capabilities:
    'browserName': 'chrome'
