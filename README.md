[![NPM version](https://badge.fury.io/js/NPM-NAME.png)](http://badge.fury.io/js/NPM-NAME)
[![Build Status](https://travis-ci.org/ORG-OR-USER/REPO-NAME.png?branch=master)](https://travis-ci.org/ORG-OR-USER/REPO-NAME)
[![Coverage Status](https://coveralls.io/repos/ORG-OR-USER/REPO-NAME/badge.png)](https://coveralls.io/r/ORG-OR-USER/REPO-NAME)
[![Dependency Status](https://david-dm.org/ORG-OR-USER/REPO-NAME.png)](https://david-dm.org/ORG-OR-USER/REPO-NAME)

This is a template for [NodeJS](http://nodejs.org/ "node.js") projects, as used by the [webplatform.org IRC bot framework](https://github.com/webplatform/irc-apparatus). The template features the following:

* The main source files can be written in JavaScript (JS) or [CoffeeScript](http://coffeescript.org/ "CoffeeScript") (CS), files can be mixed
* Same for the test sources
* [JSHint](http://www.jshint.com/ "JSHint, a JavaScript Code Quality Tool") is run against all JS files (main and test)
* [CoffeeLint](http://www.coffeelint.org/ "CoffeeLint - Lint your CoffeeScript") is run against all CS files (main and test)
* Tests are run using [Mocha](http://visionmedia.github.io/mocha/ "Mocha - the fun, simple, flexible JavaScript test framework") and [Chai](http://chaijs.com/ "Home - Chai") for great flexibility
* Tests generate coverage statistics (for CS files, the data is about the original file, not the compiled-to JS file, literate CS is also supported)
* Showing a badge (via [Gemfury](http://badge.fury.io/ "Version Badge for your RubyGems, PyPI packages, and NPM modules")) for [NPM](https://npmjs.org/ "npm - Node Packaged Modules") packages, if you publish to NPM
* Integration with [Travis CI](https://travis-ci.org/ "Travis CI - Free Hosted Continuous Integration Platform for the Open Source Community") (to get automated build and test feedback on commits and pull requests), showing a badge
* Integration with [Coveralls](https://coveralls.io/ "Coveralls - Test Coverage History & Statistics") (to keep track of the project's test coverage), showing a badge
* Showing a badge from [David DM](https://david-dm.org/ "David, a dependency management tool for Node.js projects") (to keep track of dependencies, in case they get outdated)
* Running the tests locally generates additional coverage statistics (e.g. a HTML page with per-file stats and uncovered source lines marked red)
* Custom build logic via [Grunt](http://gruntjs.com/ "Grunt: The JavaScript Task Runner")

## Installation and Customization

You obviously need NodeJS for this to work (only tested with v0.10.x), get it from the [NodeJS homepage](http://nodejs.org/). No global module installs are necessary. Publishing to NPM is optional, but encouraged. You should also familiarize yourself with the [Markdown syntax](https://help.github.com/articles/github-flavored-markdown) for writing the README and CHANGES.

1.  If you want to host your project on GitHub, [create](https://github.com/new "Create a New Repository") a new empty repository and clone it locally.  
    If you don't want to use GitHub, you should at least create a git repository locally. It will help you track the changes you make (and easily undo them if something breaks) and it let's you try out experiments on your code in separate branches.
2.  Download a [packaged version](https://github.com/webplatform/node-project-template/archive/master.zip) of this repo and unzip it into your directory.
3.  Empty this `README.md` file, but keep the badges you want (the first four lines). Fill it with your documentation later!  
    The following variables need to be replaced for the badges to work:
    * `NPM-NAME` - Name of your module on NPM.
    * `ORG-OR-USER` - GitHub user or organization where your repo lives.
    * `REPO-NAME` - GitHub repository name from step 1.
    
    You could also put a link to this template-repo here into it, so you and your contributors always know how your project is structured and how to develop for it.
4.  Edit the [LICENSE](LICENSE) file (`YEAR`, `Firstname` and `Lastname`). Replace it, if you don't want to use the MIT license. 
5.  Edit [package.json](package.json), modifying the following fields:
    * `name` - Replace `NPM-NAME` with the name of your module again.
    * `description` - Provide a short description of your work.
    * `keywords` - Some keywords would be good, this is for NPM.
    * `author` - That's you! Use this format: `Firstname Lastname <mail@mail.mail> (http://your-homepage.domain)`  
      Email-address and homepage are optional.
    * `contributors` - Additional people go here as an array of strings, same format as above.
    * `license` - Change it if you don't want to use the MIT license. Be sure to replace the `LICENSE` file, too!
    * `repository`, `bugs` and `homepage` - Replace these accordingly.
    
    You can read more about this file at NPM's [official documentation](https://npmjs.org/doc/files/package.json.html).
6.  If you want to use Travis, edit [.travis.yml](.travis.yml) to your liking. Email notifications are disabled by default, IRC notifications are used instead.  
    You can switch emails back on by setting email to `true`. If you don't want IRC notifications, delete the whole `irc` block (lines 6-10).  
    Replace `YOUR-IRC-CHANNEL` with your actual channel name and change the server if the channel is not on freenode.  
    The default 3-line IRC message template is replaced by a more concise one, announcing only one line.
    
    Sign into [Travis](https://travis-ci.org/) (it's free for public repos and uses your GitHub account) and activate the switch for your new repository on your [profile page](https://travis-ci.org/profile) there. You may need to resync your repositories, if it doesn't show up.
    
    If you don't want to use Travis, just delete the [.travis.yml](.travis.yml) file.
7.  Sign into [Coveralls](https://coveralls.io/repos/new) (it's free for public repos and uses your GitHub account) and [add your repo](https://coveralls.io/repos/new), you may need to resync here, too.
    
    If you don't want to use Coveralls, edit [Gruntfile.coffee](Gruntfile.coffee) and set `COVERALLS = false` at the top. This will still generate local coverage statistics.
8.  Replace the `NPM_NAME_COV` variable in [Gruntfile.coffee](Gruntfile.coffee) (line 160) and [index.js](index.js) (first line) with a custom one. This makes it easy to tell exactly which packages should be run under code coverage (your dependencies could also contain support for code coverage). The name of the environment variable should contain the value of your `NPM-NAME` (using only alphanumeric characters and underscore) and end in _COV or _COVERAGE.
9.  The [CHANGES.md](CHANGES.md) file can be used to record a changelog for when you release new version. If you don't want to use it, simply delete it.


## Directory Layout

* The root directory contains files relevant for build automation and some meta-data files.
    * It also contains the [index.js](index.js) file, which is the entry-point of your module.
* `node_modules` - Is a standard NPM directory, that contains the modules your project depends on (it will be created when you install the dependencies).
* `lib-src` - Put your main source code files here, subdirectories are supported. You can use .js, .coffee, .litcoffee and .coffee.md files.
* `lib` - Will be created by the build process. Your .js files and the compiled CS files will be put here.
* `lib-cov` - Before tests are run, this will be filled with instrumented files, generated from `lib-src`. Tests will actually `require()` these files, rather than the ones in `lib`.
* `test-src` - Same as `lib-src`, except for test source files (again, JS and CS are supported).
* `test` - Will be created by the build process when tests are to be run.

Don't manually put files into `lib`, `lib-cov` or `test`! The next build will clean those directories as it's first task (to make sure there are no unwanted files).

## Usage

### Installing Dependencies

Make sure to finish all the customizations first! Open a command-line / shell and navigate to your directory. Run `npm install` to install all the required modules for the build process - this can take a minute to complete. This will also build your project for the first time!

This won't install actual dependencies you need for your main code, because you haven't defined any yet. You can add dependencies by running `npm install my-dep-module-name --save` - the 'save' option will automatically add the module name to the `dependencies` field in [package.json](package.json). You can search for ready to use modules on the [NPM website](https://npmjs.org/).

### Building

After installing the dependencies for the first time, you can use `npm install` again to re-build your project. This creates the `lib` and `test` directories. If you ever want to delete all the automatically generated directories, you can use `npm run-script clean` (the build process does this always automatically when started).

You should frequently commit changed code to your local repository. If you also push to your remote repo on every commit, you can utilize Travis to get feedback from the tests and see if everything still works as expected. You can also run the tests locally, of course, but Travis supports some advanced features like testing on multiple version of NodeJS (see [here](http://about.travis-ci.org/docs/user/languages/javascript-with-nodejs/ "Travis CI: Building a Node.js project")). If you don't want to trigger a build on Travis (this would be the case if you only changed the README, for example), just include `[ci skip]` in your commit message and Travis will ignore the commit (see [here](http://about.travis-ci.org/docs/user/how-to-skip-a-build/ "Travis CI: How to skip a build")).

It's a good idea to split your project into several modules, if possible. This will provide more flexibility and make testing easier. Each public module should be added to the [index.js](index.js) file as an export.

### Linting ###

Linting is a form of static code analysis, this means that tools will take a look at your code and provide feedback if they encounter errors in syntax or semantics. The rules by which these tools operate are configurable. Take a look at lines 20 and 31 in [Gruntfile.coffee](Gruntfile.coffee) and follow the links there to setup your own options that match your environment and coding-style.

If you want to disable linting, just set `LINT = false` at the top of [Gruntfile.coffee](Gruntfile.coffee), but try fiddling around with the options first!

### Writing Tests

Tests are a good way to make sure your code actually does what it is supposed to do. Manual testing just doesn't scale with your codebase, but automated tests can and should be run frequently after changes to the code. Of course, they need to be written first, but that's easy!

There are two main development methods regarding tests: either write your code first and the tests later until everything is covered or write your tests first and the code later until every test passes. Pick whatever suits you best, you can also mix the two methods. In any case, you shouldn't spend too much time on just one thing.

You probably should know by now, that all the sources for tests are in the `test-src` directory. A good idea is to group tests about the same component or part of your module organized in sub-directories under `test-src`. Don't go into too much differentiation with those sub-directories - you can split the tests over separate files, too, and even have multiple groups of tests (or "suites") in one file. The files should have a meaningful, short name and can be written in JS or CS. There already is a [test-src/index.js](test-src/index.js) file, which will get included automatically by the test-runner. It initializes some convenience methods, so tests are even easier to write!

The test-runner used here is Mocha, which supports features like: synchronous / asynchronous tests, executing hook functions before / after tests, pending tests and exclusive / inclusive tests. Take a look at the [Mocha documentation](http://visionmedia.github.io/mocha/) to learn about these features and more (for example, how to configure test timeouts). You can find a bunch of tests in the [examples section](http://visionmedia.github.io/mocha/#example-test-suites) there, too. Basically, you create suites (via `describe()`) which can contain sub-suites and tests (via `it()`).

The build environment also uses the Chai library so you can easily write your checks. Read about the different styles and what helper methods are at your disposal in the [Chai guide](http://chaijs.com/guide/styles/). The [test/index.js](test/index.js) file activates all three styles (should, expect and assert) automatically, so you don't need to include them and can write your tests right away! Take a look at the [included test file](test-src/init/globals.js) to get an idea.

### Running Tests

Tests can be run by executing `npm test`. This will first build your project, then generate instrumented files for code coverage and finally run all tests under the `test` directory.

This will produce output like the following:

```
  the test initialization
    √ should register 'should' globally
    √ should register 'assert' globally
    √ should register 'expect' globally

  3 passing (9ms)
```

You can watch the test-runner executing your suites and tests, flagging passes and failures. It will also produce some additional files under the `test` directory:
* `coverage.html` - Contains all your main source files. It displays % coverage and SLOC stats per file and highlights lines, which aren't covered yet.
* `slow.txt` - Lists all your suites and tests by how long they ran. Useful to find slow tests.
* `lcov.txt` - This format can be imported by a number of code coverage tools.

### Publishing

If you reached a milestone that fixes some bugs or brings new functionality and all your tests pass, it's time to publish! Check out the [NPM docs](https://npmjs.org/doc/) for commands that help you with publishing, most notably [version](https://npmjs.org/doc/cli/npm-version.html) and [publish](https://npmjs.org/doc/cli/npm-publish.html). Try sticking to [Semantic Versioning](http://semver.org/) when naming your release versions.

Use `npm version major|minor|patch` to bump the package's version (choose one of major|minor|patch, according to Semantic Versioning). This also creates a new tag commit, if you are working under git. Then it's just `npm publish` and your package is up on NPM's registry!

If you are publishing for the first time, you must tell your local npm command about your NPM account, just run `npm adduser` and answer the prompts. This will either create or verify an account on NPM's registry.

### Using a package's development version

You can try out packages that aren't released on NPM yet. If there is a repository on GitHub, just link to it in your `package.json` file like so:
`"NPM-NAME": "https://api.github.com/repos/ORG-OR-USER/REPO-NAME/tarball"`

If you are building the package locally and want to use it in another local project, use NPM's [pack](https://npmjs.org/doc/cli/npm-pack.html) command. Just run `npm pack` in the package's directory - it will be built, packaged and added to the local npm cache (if there already is a package with the same name and version in the cache - either from downloading off NPM or a previous pack command - it will be overridden). Then, in your project's folder, run `npm install NPM-NAME` and it will pull the package from your cache (make sure you are depending on the correct version). You can remove a cached package via `npm cache rm NPM-NAME`.

## TODOs for this project template and this README

* maybe extra NPM script for building (instead of npm i)
* refine default lint options
* mocha-multi replacement (kills grunt's stdout)
* this as grunt-init / yo
