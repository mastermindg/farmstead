# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "farmstead/version"

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = "farmstead"
  s.version     = Farmstead::VERSION
  s.summary     = "Farmstead is a modular data pipeline platform."
  s.description = "Farmstead is a modular data pipeline platform. Farmstead makes creating and deploying a fully-functional data pipeline a snap. It is built on top of Rails/Ruby and uses Docker. This combination allows for a super-fast deployment and prototyping process."

  s.required_ruby_version     = ">= 2.2.2"
  s.required_rubygems_version = ">= 1.8.11"

  s.license = "MIT"

  s.author   = "Ken Jenney"
  s.email    = "me@kenjenney.com"
  s.homepage = "http://farmstead.kenjenney.com"

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency "bundler",         ">= 1.3.0"
  s.add_dependency "thor", ">= 0.18.1", "< 2.0"
end
