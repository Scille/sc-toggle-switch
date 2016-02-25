module.exports = (config) ->

  config.set

    # Base path, that will be used to resolve files and exclude
    basePath: '../'

    # List of files / patterns to load in the browser
    files: [
      # include relevant Angular files and libs
      'bower_components/angular/angular.js'
      'bower_components/angular-mocks/angular-mocks.js'

      # include html files
      'src/script/*.html'

      # include coffee files
      'src/script/*.coffee'

      # include unit test specs
      'test/unit/*.coffee'
    ]

    # List of files / patterns to exclude
    exclude: []

    # Enable / disable watching file and executing tests whenever any file changes
    autoWatch: false

    # Continuous Integration mode: if true, it capture browsers, run tests and exit
    singleRun: false

    # Enable or disable colors in the output (reporters and logs).
    colors: true

    # Testing framework, be sure to install the karma plugin
    frameworks: [ 'jasmine' ]

    # Start these browsers, currently available:
    # - Chrome
    # - ChromeCanary
    # - Firefox
    # - Opera
    # - Safari (only Mac)
    # - PhantomJS
    # - IE (only Windows)
    browsers: [
      'PhantomJS'
      # 'Chrome'
      # 'Firefox'
    ]

    # Progress is the default reporter.
    # Coverage is a measurement that describes how much of you code has been tested.
    reporters: [
      'progress'
      'coverage'
    ]

    # Map of preprocessors that is used mostly for plugins
    preprocessors:
      'src/script/*.html': ['ng-html2js']
      'src/script/*.coffee': ['coffee', 'coverage']
      'test/unit/*.coffee': ['coffee']

    # Which plugins to enable
    plugins: [
      'karma-junit-reporter'
      'karma-chrome-launcher'
      'karma-firefox-launcher'
      'karma-jasmine'
      'karma-phantomjs-launcher'
      'karma-coverage'
      'karma-coffee-preprocessor'
      'karma-ng-html2js-preprocessor'
    ]

    # Plugin settings
    ngHtml2JsPreprocessor:
      moduleName: (htmlPath, originalPath) ->
        pathParts = htmlPath.split('/')
        file = pathParts[pathParts.length - 1]
        file = file.replace('_template.html', 'Template')
        return file

      cacheIdFromPath: (originalPath) ->
        file = originalPath.replace('src/', '')
        return file

    coverageReporter:
      dir: '.tmp/'

      reporters: [
          type: 'html'
          subdir: 'report-html'
        ,
          type: 'text'
      ]
