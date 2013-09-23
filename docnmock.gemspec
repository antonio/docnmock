# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'docnmock/version'

Gem::Specification.new do |spec|
  spec.name          = "docnmock"
  spec.version       = Docnmock::VERSION
  spec.authors       = ["Antonio Santos"]
  spec.email         = ["antonio@santosvelasco.com"]
  spec.description   = %q{Documentate and automatically mock your APIs}
  spec.summary       = %q{Documentate and automatically mock your APIs}
  spec.homepage      = "http://github.com/antonio/docnmock"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "libnotify"
  spec.add_development_dependency "pry"
  spec.add_runtime_dependency "webmock"
end
