"use strict"

module.exports = (grunt) ->

  # Load grunt tasks automatically
  require("load-grunt-tasks") grunt

  # Configurable paths for the application
  appConfig =
    src: "src"
    dist: "dist"
    test: "test"
    demo: "demo"
    release: "release"
    tmp: ".tmp"



  ### Define the configuration for all the tasks ###
  grunt.initConfig

    # Project settings
    yeoman: appConfig

    # Watches files for changes and runs tasks based on the changed files
    watch:
      gruntfile:
        files: ["Gruntfile.js"]

      bower:
        files: ["bower.json"]
        tasks: [
          "wiredep"
          "bower"
        ]

      coffee:
        files: ["<%= yeoman.src %>/coffee/**/*.{coffee,litcoffee,coffee.md}"]
        tasks: [
          "newer:coffee"
          "newer:concat:tmp_js"
          "newer:uglify:dist"
        ]

      less:
        files: ["<%= yeoman.src %>/less/**/*.less"]
        tasks: [
          "newer:less"
          "newer:concat:tmp_css"
          "newer:cssmin:dist"
        ]

      html_template:
        files: ["<%= yeoman.src %>/html_template/**/*.html"]
        tasks: ["newer:html2js"]

      demo:
        files: [
          "<%= yeoman.demo %>/**/*.html"
          "<%= yeoman.demo %>/**/*.js"
        ]
        tasks: ["newer:copy:dist"]

      serve:
        files: [
          "<%= yeoman.dist %>/**/*.html"
          "<%= yeoman.dist %>/**/*.css"
          "<%= yeoman.dist %>/**/*.js"
        ]
        options:
          livereload: true

    # Automatically inject Bower components into the "index.html"
    wiredep:
      task:
        src: ["<%= yeoman.demo %>/index.html"]
        ignorePath: /\.\.\//

    # Copy bower installed components to dist folder
    bower:
      dev:
        dest: "<%= yeoman.dist %>/bower_components"
        options:
          expand: true

    # Serve the files from the folders listed in 'bases' on specified 'port' and 'hostname'
    express:
      all:
        options:
          port: 9000
          hostname: "localhost"
          bases: ["<%= yeoman.dist %>"]
          livereload: true

    # Open your browser at the project's URL
    open:
      all:
        path: 'http://localhost:<%= express.all.options.port%>'

    # Compiles CoffeeScript to JavaScript
    coffee:
      options:
        sourceMap: true
        sourceRoot: ""

      tmp:
        files: [
          expand: true
          cwd: "<%= yeoman.src %>/coffee"
          src: "**/*.coffee"
          dest: "<%= yeoman.tmp %>/scripts"
          ext: ".js"
        ]

    # Compiles LESS file to CSS
    less:
      options:
        compress: true
        yuicompress: true
        optimization: 2

      tmp:
        files: [
          expand: true
          cwd: "<%= yeoman.src %>/less"
          src: "**/*.less"
          dest: "<%= yeoman.tmp %>/css"
          ext: ".css"
        ]

    # Cache template for packaging
    html2js:
      options:
        base: ''
        module: 'sc-toggle-switch-template'
        singleModule: true
        useStrict: true
        htmlmin:
          collapseBooleanAttributes: true
          collapseWhitespace: true
          removeAttributeQuotes: true
          removeComments: true
          removeEmptyAttributes: true
          removeRedundantAttributes: true
          removeScriptTypeAttributes: true
          removeStyleLinkTypeAttributes: true

      tmp:
        src: ['<%= yeoman.src %>/html_template/**/*.html']
        dest: '<%= yeoman.tmp %>/scripts/toggle_switch_template.js'

    # Copies remaining files to places other tasks can use
    copy:
      dist:
        files: [
          expand: true
          dot: true
          cwd: "<%= yeoman.demo %>"
          dest: "<%= yeoman.dist %>"
          src: [
            "*.html"
            "**/*.html"
            "*.js"
            "**/*.js"
          ]
        ]

    # Concatenates Javascript and/or CSS files
    concat:
      tmp_js:
        src: ['<%= yeoman.tmp %>/scripts/**/*.js']
        dest: '<%= yeoman.tmp %>/concat/toggle_switch.js'

      tmp_css:
        src: ['<%= yeoman.tmp %>/css/**/*.css']
        dest: '<%= yeoman.tmp %>/concat/toggle_switch.css'


    # Minifies the Javascript file
    uglify:
      options:
        # Specify mangle false to prevent changes to your variable and function names
        mangle: false
        # The banner is inserted at the top of the output
        banner: '/*! toggle-switch <%= grunt.template.today("dd-mm-yyyy") %> */\n'

      dist:
        files: '<%= yeoman.dist %>/scripts/toggle_switch.min.js': ['<%= concat.tmp_js.dest %>']

      release:
        files: '<%= yeoman.release %>/scripts/toggle_switch.min.js': ['<%= concat.tmp_js.dest %>']

    # Minifies the CSS file
    cssmin:
      dist:
        files: '<%= yeoman.dist %>/css/toggle_switch.min.css': ['<%= concat.tmp_css.dest %>']

      release:
        files: '<%= yeoman.release %>/css/toggle_switch.min.css': ['<%= concat.tmp_css.dest %>']

    # Empties folders to start fresh
    clean:
      dist:
        files: [
          dot: true
          src: [
            "<%= yeoman.tmp %>"
            "<%= yeoman.dist %>/**/*"
            ]
        ]

      release:
        files: [
          dot: true
          src: [
            "<%= yeoman.tmp %>"
            "<%= yeoman.release %>/**/*"
          ]
        ]

    # Unit Testing with Karma
    karma:
      options:
        configFile: "<%= yeoman.test %>/karma_conf.js"

      unit:
        singleRun: true


  ### Custom tasks ###
  grunt.registerTask "build", [
    "clean:dist"
    "bower"
    "wiredep"
    "copy:dist"
    "less"
    "coffee"
    "html2js"
    "concat"
    "uglify:dist"
    "cssmin:dist"
  ]

  grunt.registerTask "unit-test", [
    "build"
    "karma"
  ]

  grunt.registerTask "serve", [
    "build"
    "express"
    "open"
    "watch"
  ]

  grunt.registerTask "default", [
    "build"
    "watch"
  ]

  grunt.registerTask "release", [
    "clean:release"
    "less"
    "coffee"
    "html2js"
    "concat"
    "uglify:release"
    "cssmin:release"
  ]
