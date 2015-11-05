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
<div toggle-switch-directive
    ng-model="switchModel"
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

*Note:*
* **ng-model:** Will try to bind to the property given by evaluating the expression on the current scope. If the property doesn't already exist on this scope, it will be created implicitly and added to the scope.
* **is-disabled:** Determines if the switch is disabled or not. 
* **is-summarised:** Determines if the switch is summarised or not.
* **is-animated:** Determines if the switch animates when toggled.
* **switch-size:** Sets the size class. It can be `xsmall`, `small`, `medium` (as default), `large`, `xlarge`.
* **left-label:** Sets the left label text.
* **right-label:** Sets the right label text.
* **knob-label:** Sets the knob label text.
* **left-label-color:** Sets the left label background color.
* **right-label-color:** Sets the right label background color.
* **left-value:** Sets the left position value. It is `true` as default.
* **right-value:** Sets the right position value. It is `false` as default.
* **knob-label-color:** Sets the knob label background color.
* **border-color:** Sets the border color.


## Directory structure

```
sc-toggle-switch/
    |
    |- demo/                    -> Contains JavaScript file and HTML file. (Used by Grunt to run the demonstration)
    |
    |- release/                 -> Contains the production minified release of the app.
    |   |- css/                     -> Minified CSS file.
    |   '- script/                  -> Minified JavaScript file.
    |
    |- src/                     -> Contains CoffeeScript sources, LESS styles and other assets.
    |   |- coffee/                  -> CoffeeScript sources.
    |   |- html_template/           -> HTML that contains Angular-specific elements and attributes.
    |   '- less/                    -> LESS sources.
    |
    '- test/                    -> Contains tests for the application.
        |- e2e/                     -> End-To-End tests for AngularJS applications. (Protractor)
        '- unit/                    -> Unit tests for AngularJS components. (Karma)
```

## Demonstration

Launch the demo with:
```bash
$ grunt serve
```


## Running tests

### Unit Tests (Karma)

Executing Unit Tests with Grunt:
```bash
$ grunt unit-test
```

Executing Unit Tests by Karma:
```bash
$ karma start ./test/karma_conf.coffee --single-run
```

It will also generate HTML test coverage report inside ./.tmp/report-html directory.

### End-To-End Tests (Protractor)

Executing End-To-End Tests with Grunt:
```bash
$ grunt e2e-test
```

Executing End-To-End Tests by Protractor:
```bash
$ protractor ./test/protractor_conf.coffee
```


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
