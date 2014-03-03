require 'bundler'
Bundler.setup

require 'erb'

desc 'Run all tests in phantom-jasmine'
task :test do
  compile_test do |filename|
    puts `mocha-phantomjs #{filename}`
    File.delete filename
  end
end

namespace :test do
  task :preview do
    compile_test do |filename|
      `open #{filename}`
    end
  end
end


def compile(file)
  `coffee -p #{file}`
end

def asset name
  File.read "test/lib/#{name}"
end

def render
  ERB.new(asset 'testrunner.erb').result
end

def compile_test
  filename = "/tmp/testrunner#{rand 0..99999}.html"
  IO::write filename, render
  yield(filename) if block_given?
end

