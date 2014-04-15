# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reel/rack/version'

Gem::Specification.new do |spec|
  spec.name          = "reel-rack"
  spec.version       = Reel::Rack::VERSION
  spec.authors       = ["Tony Arcieri", "Jonathan Stott"]
  spec.email         = ["tony.arcieri@gmail.com"]
  spec.description   = "Rack adapter for Reel"
  spec.summary       = "Rack adapter for Reel, a Celluloid::IO web server"
  spec.homepage      = "https://github.com/celluloid/reel-rack"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "reel", ">= 0.5.0"
  spec.add_runtime_dependency "rack", ">= 1.4.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
