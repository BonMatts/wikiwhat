# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require File.expand_path('../lib/wikiwhat/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "wikiwhat"
  spec.version       = Wikiwhat::VERSION
  spec.authors       = ["Bonnie Mattson, Clare Glinka"]
  spec.email         = ["blmattson@gmail.com, glinka.cb@gmail.com"]
  spec.description   = "Gem for extracting specific content from Wikipedia articles."
  spec.summary       = ""
  spec.homepage      = "https://github.com/kitsunetsuki/Wikiwhat"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "json"
  spec.add_dependency "rest-client"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock", "~> 1.8.0"
  spec.add_development_dependency "rspec"
end
