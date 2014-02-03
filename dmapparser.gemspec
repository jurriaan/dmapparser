# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dmapparser/version'

Gem::Specification.new do |spec|
  spec.name          = 'dmapparser'
  spec.version       = DMAPParser::VERSION
  spec.authors       = ['Jurriaan Pruis']
  spec.email         = ['email@jurriaanpruis.nl']
  spec.summary       = %q{Parses DMAP data}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'rake'
end
