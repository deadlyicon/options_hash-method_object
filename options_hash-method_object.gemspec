# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'options_hash/method_object'

Gem::Specification.new do |spec|
  spec.name          = "options_hash-method_object"
  spec.version       = OptionsHash::MethodObject::VERSION
  spec.authors       = ["Jared Grippe"]
  spec.email         = ["jared@deadlyicon.com"]
  spec.description   = %q{A MethodObject with an OptionsHash built in}
  spec.summary       = %q{A MethodObject with an OptionsHash built in}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency     'options_hash'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry-debugger'
end
