describe "complex", ->

  before ->
    define "A", -> class A
    define "B", ["A"], (A) -> class B extends A
    define "C", (require) ->
      B = require "B"
      class C extends B
    define "D", (require) ->
      class window.D
        template: require("E")
    define "E", -> "Peter"

  it "handles complex object graphs", ->
    expect(require("B")).to.be.a "function"

  it "does not mix up types", ->
    expect(require("B").__super__.constructor.name).to.equal "A"

  it "handles inline requires", ->
    expect(require("C").__super__.constructor.name).to.equal "B"

  it "handles deep requires", ->
    D = require "D"
    expect(new D().template).to.be.equal "Peter"
