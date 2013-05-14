# -*- encoding: utf-8 -*-
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mosaic/errors/version"

Gem::Specification.new do |gem|
  gem.name        = "mosaic-errors"
  gem.version     = Mosaic::Errors::VERSION
  gem.date        = Date.today.to_s

  gem.summary     = "Rails 3.x custom error page support."
  gem.description = "A gem to simplify implementation of custom error pages in a Rails 3.x application."

  gem.authors     = ["Kel Stopper"]
  gem.email       = ["kel.stopper@mosaic.com"]
  gem.homepage    = "http://git.corp.mosaic.com/mosaiccis/mosaic-errors"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "haml", [">= 0"]

  gem.add_development_dependency "rake", [">= 0"]
  gem.add_development_dependency "shoulda", [">= 0"]
end

