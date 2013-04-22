# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simply_paginate/version'

Gem::Specification.new do |spec|
  spec.name          = "simply_paginate"
  spec.version       = SimplyPaginate::VERSION
  spec.authors       = ["Álvaro F. Lara"]
  spec.email         = ["alvarola@gmail.com"]
  spec.description   = %q{This gem is a simple paginator for Enumerable collections}
  spec.summary       = %q{You enumerate it we will simply paginate it}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "rake"
end
