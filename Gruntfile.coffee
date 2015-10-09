"use strict"

module.exports = (grunt) ->

  # Load grunt tasks automatically
  require("load-grunt-tasks") grunt

  # Configurable paths for the application
  appConfig =
    src: "src"
    dist: "dist"
    demo: "demo"
    release: "release"



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
        tasks: ["newer:coffee:dist"]

      less:
        files: ["<%= yeoman.src %>/less/**/*.less"]
        tasks: ["newer:less:dist"]

      html_template:
        files: ["<%= yeoman.src %>/html_template/**/*.html"]
        tasks: ["newer:copy:html_template"]

      demo:
        files: [
          "<%= yeoman.demo %>/**/*.html"
          "<%= yeoman.demo %>/**/*.js"
        ]
        tasks: ["newer:copy:demo"]

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

      dist:
        files: [
          expand: true
          cwd: "<%= yeoman.src %>/coffee"
          src: "**/*.coffee"
          dest: "<%= yeoman.dist %>/scripts"
          ext: ".js"
        ]

      release:
        files: [
          expand: true
          cwd: "<%= yeoman.src %>/coffee"
          src: "**/*.coffee"
          dest: "<%= yeoman.release %>/scripts"
          ext: ".js"
        ]

    # Compiles LESS file to CSS
    less:
      options:
        compress: true
        yuicompress: true
        optimization: 2

      dist:
        files: [
          expand: true
          cwd: "<%= yeoman.src %>/less"
          src: "**/*.less"
          dest: "<%= yeoman.dist %>/css"
          ext: ".css"
        ]

      release:
        files: [
          expand: true
          cwd: "<%= yeoman.src %>/less"
          src: "**/*.less"
          dest: "<%= yeoman.release %>/css"
          ext: ".css"
        ]

    # Copies remaining files to places other tasks can use
    copy:
      html_template:
        files: [
          expand: true
          dot: true
          cwd: "<%= yeoman.src %>"
          dest: "<%= yeoman.dist %>"
          src: [
            "*.html"
            "**/*.html"
          ]
        ]

      demo:
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

    # Empties folders to start fresh
    clean:
      dist:
        files: [
          dot: true
          src: "<%= yeoman.dist %>/**/*"
        ]
      release:
        files: [
          dot: true
          src: "<%= yeoman.release %>/**/*"
        ]



  ### Custom tasks ###
  grunt.registerTask "build", [
    "clean:dist"
    "bower"
    "wiredep"
    "copy"
    "less:dist"
    "coffee:dist"
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
    "less:release"
    "coffee:release"
  ]
