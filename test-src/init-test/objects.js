var init = require('../init');

describe("the test initialization", function() {
  it("should provide an init object and register 'should' globally", function() {
    init.should.be.an('object');
  });
  
  it("should register 'assert' globally", function() {
    assert(assert == require('chai').assert);
  });
  
  it("should register 'expect' globally", function() {
    expect(expect == require('chai').expect).to.be.true;
  });
});
