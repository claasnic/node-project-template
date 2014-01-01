[![NPM version](https://badge.fury.io/js/NPM-NAME.png)](http://badge.fury.io/js/NPM-NAME)
[![Build Status](https://travis-ci.org/ORG-OR-USER/REPO-NAME.png?branch=master)](https://travis-ci.org/ORG-OR-USER/REPO-NAME)
[![Coverage Status](https://coveralls.io/repos/ORG-OR-USER/REPO-NAME/badge.png)](https://coveralls.io/r/ORG-OR-USER/REPO-NAME)
[![Dependency Status](https://david-dm.org/ORG-OR-USER/REPO-NAME.png)](https://david-dm.org/ORG-OR-USER/REPO-NAME)

This is a template for [NodeJS](http://nodejs.org/ "node.js") projects, it features the following:

* The main source files can be written in JavaScript (JS) or [CoffeeScript](http://coffeescript.org/ "CoffeeScript") (CS), files can be mixed
* Same for the test sources
* [JSHint](http://www.jshint.com/ "JSHint, a JavaScript Code Quality Tool") is run against all JS files (main and test)
* [CoffeeLint](http://www.coffeelint.org/ "CoffeeLint - Lint your CoffeeScript") is run against all CS files (main and test)
* Tests are run using [Mocha](http://visionmedia.github.io/mocha/ "Mocha - the fun, simple, flexible JavaScript test framework") to allow flexibility
* Tests generate coverage statistics (for CS files, the data is about the original file, not the compiled-to JS, literate CS is also supported)
* Showing a badge (via [this](http://badge.fury.io/ "Version Badge for your RubyGems, PyPI packages, and NPM modules")) for [NPM](https://npmjs.org/ "npm - Node Packaged Modules") packages, if you publish to NPM
* Integration with [Travis CI](https://travis-ci.org/ "Travis CI - Free Hosted Continuous Integration Platform for the Open Source Community") (to get automated build and test feedback on commits and pull requests), showing a badge
* Integration with [Coveralls](https://coveralls.io/ "Coveralls - Test Coverage History & Statistics") (to keep track of the project's test coverage), showing a badge
* Showing a badge from [David DM](https://david-dm.org/ "David, a dependency management tool for Node.js projects") (to keep track of dependencies, in case they get outdated)
* Running the tests locally outputs additional coverage statistics (like a HTML page with per-file stats and uncovered source lines marked red)
* Custom build logic via [Grunt](http://gruntjs.com/ "Grunt: The JavaScript Task Runner")

## Installation and Customization

You obviously need NodeJS for this to work (only tested with v0.10.x), get it from the [NodeJS homepage](http://nodejs.org/). No global module installs are necessary. Publishing to NPM is optional, but encouraged. You should also familiarize yourself with the [Markdown syntax](https://help.github.com/articles/github-flavored-markdown) for writing the readme and changelog.

1.  If you want to host your project on GitHub, [create](https://github.com/new "Create a New Repository") a new empty repository and clone it locally.  
    If you don't want to (you really should!), just create a new empty directory.
2.  Download a [packaged version](https://github.com/webplatform/node-project-template/archive/master.zip) of this repo and unzip it into your directory.
3.  Empty this `README.md` file, but keep the badges you want (the first four lines). Fill it with your documentation later!  
    The following variables need to be replaced for the badges to work:
    * `NPM-NAME` - Name of your module on NPM.
    * `ORG-OR-USER` - GitHub user or organization where your repo lives.
    * `REPO-NAME` - GitHub repository name from step 1.
    
    You could also put a link to this template-repo here into it, so you and your contributors always know how your project is structured and how to develop for it.
4.  Edit the `LICENSE` file (`YEAR`, `Firstname` and `Lastname`). Replace it, if you don't want to use the MIT license. 
5.  Edit `package.json`, modifying the following fields:
    * `name` - Replace `NPM-NAME` with the name of your module again.
    * `description` - Provide a short description of your work.
    * `keywords` - Some keywords would be good, this is for NPM.
    * `author` - That's you! Use this format: `Firstname Lastname <mail@mail.mail> (http://your-homepage.domain)`  
      Email-address and homepage are optional.
    * `contributors` - Additional people go here as an array of strings, same format as above.
    * `license` - Change it if you don't want to use the MIT license. Be sure to replace the `LICENSE` file, too!
    * `repository`, `bugs` and `homepage` - Replace these accordingly.
    
    You can read more about this file at NPM's [official documentation](https://npmjs.org/doc/files/package.json.html).
6.  If you want to use Travis, edit `.travis.yml` to your liking. Email notifications are disabled by default, IRC notifications are used instead.  
    You can switch emails back on by setting email to `true`. If you don't want IRC notifications, delete the whole `irc` block (lines 6-10).  
    Replace `YOUR-IRC-CHANNEL` with your actual channel name and change the server if the channel is not on freenode.  
    The default 3-line IRC message template is replaced by a more concise one, announcing only one line.
    
    Sign into [Travis](https://travis-ci.org/) (it's free for public repos and uses your GitHub account) and activate the switch for your new repository on your [profile page](https://travis-ci.org/profile) there. You may need to resync your repositories, if it doesn't show up.
    
    If you don't want to use Travis, just delete the `.travis.yml` file.
7.  Sign into [Coveralls](https://coveralls.io/repos/new) (it's free for public repos and uses your GitHub account) and [add your repo](https://coveralls.io/repos/new), you may need to resync here, too.
    
    If you don't want to use Coveralls, edit `Gruntfile.coffee` and set `COVERALLS = false` at the top. This will still generate local coverage statistics.
8.  Replace the `NODE_NAME_COV` variable in `Gruntfile.coffee` (line 159) and `index.js` (first line) with a custom one.
9.  The `CHANGES.md` file can be used to record a changelog for when you release new version. If you don't want to use it, simply delete it.


## Directory Layout

* The root drectory contains files relevant for build automation and some meta-data files.
* `node_modules` - Is a standard NPM directory, that contains the modules your project depends on.
* `lib-src` - Put your main source code files here, subdirectories are supported. You can use .js, .coffee, .litcoffee and .coffee.md files.
* `lib` - Will be created by the build process. Your .js files and the compiled CS files will be put here.
* `lib-cov` - Before tests are run, this will be filled with instrumented files, generated from `lib-src`. Tests will actually `require()` these files, rather than the ones in `lib`.
* `test-src` - Same as `lib-src`, except for test source files (again, JS and CS are supported).
* `test` - Will be created by the build process when tests are to be run.

Don't manually put files into `lib`, `lib-cov` or `test`! The next build will clean those directories as it's first task (to make sure there are no unwanted files).

## Usage

### Installing Dependencies

Make sure to finish all the customizations first! Open a command-line / shell and navigate to your directory. Run `npm install` to install all the required modules for the build process - it can take a minute to complete. This will also build your project for the first time!

### Building

After installing the dependencies for the first time, you can use `npm install` again to re-build your project. This creates the `lib` and `test` directories. If you ever want to clean up the automatically generated directories, you can use `npm run-script clean` (the build process does this always automatically at start).

### Writing Tests

TODO (folders, init, mocha, chai)

### Running Tests

Test can be run by executing `npm test`. This will build your project first, generate instrumented files for code coverage and then run all tests under the `test` directory.

### Publishing

TODO (ignores, include lib, npm version, tag)

## TODO

* TODOs
* mocha-multi replacement (kills grunt's stdout)
* npm pack?
* test all this again
