module.exports = function(config){
  config.set({
    //  root path location that will be used to resolve all relative paths in files and exclude sections, should be the root of your project
    basePath: '../',

    // files to include, ordered by dependencies
    files: [
      // include relevant Angular files and libs
      'bower_components/angular/angular.js',
      'bower_components/angular-mocks/angular-mocks.js',

      // include js files
      'dist/app.js',
      'dist/scripts/toggle_switch.min.js',

      // include unit test specs
      'test/unit/*.js'
    ],

    // files to exclude
    exclude: [],

    // karma has its own autoWatch feature but Grunt watch can also do this
    autoWatch: false,

    // testing framework, be sure to install the karma plugin
    frameworks: ['jasmine'],

    // browsers to test against, be sure to install the correct karma browser launcher plugin
    browsers : ['PhantomJS', 'Chrome', 'Firefox'],

    // progress is the default reporter. Coverage is a measurement that describes how much of you code has been tested.
    reporters: ['progress', 'coverage'],

    // map of preprocessors that is used mostly for plugins
    preprocessors: {
      'dist/app.js': ['coverage'],
      'dist/scripts/toggle_switch.min.js': ['coverage']
    },

    // list of karma plugins
    plugins: [
        'karma-junit-reporter',
        'karma-chrome-launcher',
        'karma-firefox-launcher',
        'karma-jasmine',
        'karma-phantomjs-launcher',
        'karma-coverage'
    ],

    // plugin settings
    coverageReporter: {
      // type of file to output, use text to output to console
      type : 'text'
    }
})}
