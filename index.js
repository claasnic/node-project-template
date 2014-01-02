var lib = process.env.NPM_NAME_COV ? './lib-cov' : './lib';

// use the lib var to pull in the source from the right directory,
// depending on if coverage stats should be collected or not, e.g.:
// exports.main = require(lib + '/main.js');
