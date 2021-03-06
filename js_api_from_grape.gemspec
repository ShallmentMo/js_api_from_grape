# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'js_api_from_grape/version'

Gem::Specification.new do |spec|
  spec.name          = "js_api_from_grape"
  spec.version       = JsApiFromGrape::VERSION
  spec.authors       = ["ShallmentMo"]
  spec.email         = ["ShallmentMo@gmail.com"]

  spec.summary       = "You can generate js api library when you using [grape](https://github.com/ruby-grape/grape) gem."
  spec.description   = "With using grape, I try to provide a js api library with grape. Mostly I hope it can do the frontend validation for me ."
  spec.homepage      = "https://github.com/ShallmentMo/js_api_from_grape"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "grape", "~> 0.17"
  spec.add_dependency "js_regex", "~> 1.0"
  
  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry", "~> 0.10"
end
