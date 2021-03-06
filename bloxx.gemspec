# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bloxx/version'

Gem::Specification.new do |spec|
  spec.name          = 'bloxx'
  spec.version       = Bloxx::VERSION
  spec.authors       = ['Paul Palmer']
  spec.email         = ['b.paul.palmer@gmail.com']

  spec.summary       = %q{Toolkit for interacting with Minecraft.}
  spec.description   = %q{This gem is a collection of classes for generating Minecraft client
                          commands. The long-term goal is for it to become a complete toolkit
                          for creating client-side bots.}
  spec.homepage      = %q{TODO: Put your gem's website or public repo URL here.}
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = %q{TODO: Set to 'http://mygemserver.com'}
  else
    raise %q{RubyGems 2.0 or newer is required to protect against public gem pushes.}
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-nc'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-remote'
  spec.add_development_dependency 'pry-nav'
end
