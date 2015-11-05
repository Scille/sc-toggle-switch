# Scille Toggle Switch (for Angularjs)

Toggle Switches for AngularJS. This library is created by DUBOIS Romain and maintained by the Scille team.


## Installation

### Required Node Tools

In order to get started, you'll want to install some tools globally.
```bash
$ sudo apt-get install nodejs
$ sudo ln /usr/bin/nodejs /usr/bin/node

$ sudo apt-get install npm
$ sudo npm install -g bower grunt-cli coffee-script karma-cli protractor
```

### Download git repository

```bash
$ git clone https://github.com/Scille/sc-toggle-switch
$ cd sc-toggle-switch
$ npm install
$ bower install
```

### Install with bower

```bash
$ bower install sc-toggle-switch
```


## Usage

### Registration

To be able to use the directive, you need to register the sc-toggle-switch module as a dependency:
```javascript
angular.module('yourModule', ['sc-toggle-switch'
    // other dependencies
]);
```

### Directive

The directive can work on both attribute and element levels.
```html
<div toggle-switch-directive ng-model="switchModel"
    is-disabled="isDisabled"
    is-summarised="isSummarised"
    is-animated="isAnimated"
    switch-size="{{switchSize}}"
    left-label="{{leftLabel}}"
    right-label="{{rightLabel}}"
    knob-label="{{knobLabel}}"
    left-label-color="{{leftLabelColor}}"
    right-label-color="{{rightLabelColor}}"
    left-value="leftValue"
    right-value="rightValue"
    knob-label-color="{{knobLabelColor}}"
    border-color="{{borderColor}}">
</div>
```

TODO


## Directory structure

* demo - contains JavaScript file and HTML file. (Used by grunt to run the demonstration)
* release - contains the production minified release of the app.
  * css - minified CSS file.
  * script - minified JavaScript file.
* src - contains CoffeeScript sources, LESS styles and other assets.
  * src/coffee - CoffeeScript sources.
  * src/html_template - HTML that contains Angular-specific elements and attributes.
  * src/less - LESS sources.
* test - contains tests for the application.
  * test/e2e -  end-to-end tests for AngularJS applications. (Protractor)
  * test/unit - unit tests for AngularJS components. (Karma)


## Demonstration

Launch the demo with:
```bash
$ grunt serve
```


## Running tests

TODO


## Other toggle-switch

* see [angular-bootstrap-switch](https://github.com/frapontillo/angular-bootstrap-switch)
* see [bootstrap-switch](https://github.com/nostalgiaz/bootstrap-switch)
* see [angular-toggle-switch](https://github.com/JumpLink/angular-toggle-switch)
* see [angular-toggle-switch](https://github.com/cgarvis/angular-toggle-switch)


## Contributors

DUBOIS Romain, Engineer R&D at [SCILLE](http://scille.eu/)
<dubois.rom@gmail.com>

MEZINO Vincent, Engineer R&D at [SCILLE](http://scille.eu)
<vincent.mezino@gmail.com>


## License

Licensed under the MIT License
