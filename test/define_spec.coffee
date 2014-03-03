describe "define", ->
  it "should be usable", ->
    expect(define).to.be.a "function"

  describe "basic definition of methods", ->
    beforeEach ->
      hazelnut_reset()
      define "a", -> 5
      define "b", -> 10

    it "supports the classic almondish syntax", ->
      define "test/module", ["a", "b"], (a, b) ->
        return [a, b]
      expect(require "test/module").to.be.eql [5, 10]

    it "supports syntactic sugar RequireJS provides", ->
      define "test/module", (require) ->
        a = require("a")
        b = require("b")
        a + b
      expect(require "test/module").to.be.equal 15

    it "simply returns already defined modules", ->
      define "persisted", -> {}
      persisted = require "persisted"
      persisted.value = 12345

      expect(require("persisted").value).to.equal 12345

    it "doesn't alter defined functions", ->
      define "function", -> (a, b) -> a + b

      expect(require("function")).to.be.a "function"
      expect(require("function").call this, 5, 6).to.equal 11
