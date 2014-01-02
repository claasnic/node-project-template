describe("the test initialization", function() {
  it("should register 'should' globally", function() {
    Object.create(Object.prototype).should.be.an('object');
  });
  
  it("should register 'assert' globally", function() {
    assert(assert === require('chai').assert);
  });
  
  it("should register 'expect' globally", function() {
    expect(expect === require('chai').expect).to.be.true;
  });
});
