# encoding: utf-8

require 'rake'
require 'rake/testtask'
require "bundler/gem_tasks"

task :default => [:test]

Rake::TestTask.new(:test) do |t|
  t.pattern = 'test/*_test.rb'
  t.verbose = true
end

Rake::Task[:test].comment = "Run all tests"

