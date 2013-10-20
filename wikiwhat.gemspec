# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wikiwhat/version'

Gem::Specification.new do |spec|
  spec.name          = "wikiwhat"
  spec.version       = Wikiwhat::VERSION
  spec.authors       = ["Bonnie Mattson, Clare Glinka"]
  spec.email         = ["blmattson@gmail.com, glinka.cb@gmail.com"]
  spec.description   = "media wiki api wrapper"
  spec.summary       = "soooooo coool"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
