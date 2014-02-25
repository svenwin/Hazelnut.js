Hazelnut.js
===========

@license hazelnut 0.0.1 Copyright (c) 2014, Sven Winkler.
Available via the MIT or new BSD license.

Take global object to attach our handlers to.

    ((global) ->

Provide a global object to register new modules.

At first modules should be added to a queue (waiting). Upon first usage the return value will be cached (defined).

      waiting = {}

      defined = {}

Support the syntactic sugar version.

      defineWithoutDependencies = (name, fn) ->
        waiting[name] = fn

Support the standard case

      defineWithWrappedDependencies = (name, dependencies, fn) ->
        waiting[name] = (require) ->
          resolved = for dependency in dependencies
            require dependency
          return fn.apply @, resolved

      global.hazelnut_reset = ->
        defined = {}
        waiting = {}

      global.define = (name, dependencies, fn) ->

Last argument is a function? Then it's the classic form.

        if fn?
          defineWithWrappedDependencies name, dependencies, fn

Otherwise, the function is hidden in dependencies.

        else
          defineWithoutDependencies name, dependencies

Require

      global.require = (dependency) ->
          if waiting[dependency]?
            defined[dependency] =
              waiting[dependency].call(this, require)
            delete waiting[dependency]
            defined[dependency]
          else if defined[dependency]?
            defined[dependency]
          else
            throw "dependency #{dependency} is not defined"
    )(window)
