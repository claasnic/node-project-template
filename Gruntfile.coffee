fs = require 'fs'
path = require 'path'
cp = require 'child_process'
mkdirp = require 'mkdirp'
wrench = require 'wrench'
{CoverageInstrumentor} = require 'coffee-coverage'
instrument = require 'jscoverage/lib/instrument'

COVERALLS = true
LINT = true

module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    clean:
      lib: ['lib']
      cov: ['lib-cov']
      test: ['test']
    jshint:
      options: # see http://www.jshint.com/docs/options/
        curly: true
        indent: 2
        node: true
      lib: ['index.js', 'lib-src/**/*.js']
      test:
        options:
          '-W030': true # Expected an assignment or function call and instead saw an expression: ...to.be.true
        files:
          src: ['test-src/**/*.js']
    coffeelint:
      options: # see http://www.coffeelint.org/#options
        'max_line_length':
          level: 'ignore'
        'no_stand_alone_at':
          level: 'error'
        'space_operators':
          level: 'error'
      build: ['Gruntfile.coffee']
      lib: ['lib-src/**/*.coffee','lib-src/**/*.litcoffee','lib-src/**/*.coffee.md']
      test: ['test-src/**/*.coffee','test-src/**/*.litcoffee','test-src/**/*.coffee.md']
    copy:
      lib:
        expand: true
        cwd: 'lib-src'
        src: '**/*.js'
        dest: 'lib/'
      test:
        expand: true
        cwd: 'test-src'
        src: '**/*.js'
        dest: 'test/'
    coffee:
      options:
        bare: true
      lib:
        expand: true
        cwd: 'lib-src'
        src: ['**/*.coffee','**/*.litcoffee','**/*.coffee.md']
        dest: 'lib/'
        ext: '.js'
      test:
        expand: true
        cwd: 'test-src'
        src: ['**/*.coffee','**/*.litcoffee','**/*.coffee.md']
        dest: 'test/'
        ext: '.js'
    mochaTest:
      lib:
        options:
          require: ['lib-cov/init-cov.js', 'test/index.js']
        src: ['test/**/*.js', '!test/index.js']
  
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-mocha-test'
  
  grunt.registerTask 'coverage', 'Build coverage files.', ->
    done = @async()
    fs.mkdirSync 'lib-cov'
    initStream = fs.createWriteStream 'lib-cov/init-cov.js',
      encoding: 'utf8'
    jscoverageHeader = """
    (function () {
      var BASE;
      if (typeof global === 'object') {
        BASE = global;
      } else if (typeof window === 'object') {
        BASE = window;
      } else {
        throw new Error('[jscoverage] unknow ENV!');
      }
      if (!BASE._$jscoverage) {
        BASE._$jscoverage = {};
        BASE._$jscoverage_cond = {};
        BASE._$jscoverage_done = function (file, line, express) {
          if (arguments.length === 2) {
            BASE._$jscoverage[file][line] ++;
          } else {
            BASE._$jscoverage_cond[file][line] ++;
            return express;
          }
        };
        BASE._$jscoverage_init = function (base, file, lines) {
          var tmp = [];
          for (var i = 0; i < lines.length; i ++) {
            tmp[lines[i]] = 0;
          }
          base[file] = tmp;
        };
      }
    })();\n\n
    """
    initStream.write jscoverageHeader
    jsLines = csLines = 0
    rgxAnyCoffee = /\.(litcoffee|coffee(\.md)?)$/
    rgxLiterateCoffee = /\.(litcoffee|coffee\.md)$/
    csCov = new CoverageInstrumentor
    
    files = wrench.readdirSyncRecursive 'lib-src'
    for file in files
      srcFile = path.join 'lib-src', file
      continue if not fs.statSync(srcFile).isFile()
      dstFile = path.join 'lib-cov', file
      fileName = file.replace(/^[\/\\]/, '').replace(/\\/g, '\/')
      if /\.js$/.test file
        js = fs.readFileSync srcFile,
          encoding: 'utf8'
        result = instrument file, js
        covered = []
        # header
        covered.push '_$jscoverage_init(_$jscoverage, "' + fileName + '",' + JSON.stringify(result.lines)  + ');'
        covered.push '_$jscoverage_init(_$jscoverage_cond, "' + fileName + '",' + JSON.stringify(result.conditions)  + ');'
        covered.push '_$jscoverage["' + fileName + '"].source = ' + JSON.stringify(result.src) + ';'
        initStream.write '\n' + (covered.join '\n') + '\n'
        # body
        covered.unshift jscoverageHeader
        mkdirp.sync path.dirname dstFile
        covered.push result.code
        fs.writeFileSync dstFile, covered.join '\n'
        jsLines += result.lines.length
      else if rgxAnyCoffee.test file
        dstFile = dstFile.replace(rgxAnyCoffee, '.js')
        cs = fs.readFileSync srcFile,
          encoding: 'utf8'
        result = csCov.instrumentCoffee fileName, cs,
          bare: true
          initFileStream: initStream
          path: 'relative'
        mkdirp.sync path.dirname dstFile
        fs.writeFileSync dstFile, result.init + result.js
        csLines += result.lines
    
    grunt.log.writeln "Annotated #{jsLines.toString().cyan} JS and #{csLines.toString().cyan} CS lines."
    initStream.end done
  
  grunt.registerTask 'test', 'Build, generate coverage, run tests.', ->
    process.env.NPM_NAME_COV = true
    if process.env.TRAVIS
      if COVERALLS
        grunt.config.set 'mochaTest.lib.options.reporter', 'mocha-lcov-reporter'
        grunt.config.set 'mochaTest.coverage.options.reporter', 'mocha-lcov-reporter'
        grunt.config.set 'mochaTest.coverage.options.quiet', 'true'
        grunt.config.set 'mochaTest.coverage.options.captureFile', 'test/lcov.txt'
        grunt.task.run ['build', 'coverage', 'mochaTest', 'coveralls']
      else
        grunt.config.set 'mochaTest.lib.options.reporter', 'spec'
        grunt.task.run ['build', 'coverage', 'mochaTest']
    else
      process.env.multi = 'spec=- mocha-slow-reporter=test/slow.txt html-cov=test/coverage.html mocha-lcov-reporter=test/lcov.txt'
      grunt.config.set 'mochaTest.lib.options.reporter', 'mocha-multi'
      grunt.task.run ['build', 'coverage', 'mochaTest']
  
  grunt.registerTask 'coveralls', 'Push to Coveralls.', ->
    grunt.log.writeln 'pushing to coveralls...'
    @requires 'mochaTest'
    done = @async()
    cp.exec 'cat ../test/lcov.txt | ../node_modules/.bin/coveralls', { cwd: './lib-src' }, (err, stdout, stderr) ->
      grunt.log.writeln stdout + stderr
      done err
  
  grunt.registerTask 'build', ->
    grunt.task.run ['clean']
    grunt.task.run ['jshint', 'coffeelint'] if LINT
    grunt.task.run ['copy', 'coffee']
  
  grunt.registerTask 'default', ['build']
