# frozen_string_literal: true

version = File.read(File.expand_path("VERSION", __dir__)).strip

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = "farmstead"
  s.version     = version
  s.summary     = "Farmstead is a modular data pipeline platform."
  s.description = "Farmstead is a modular data pipeline platform. Farmstead makes creating and deploying a fully-functional data pipeline a snap. It is built on top of Rails/Ruby and uses Docker. This combination allows for a super-fast deployment and prototyping process."

  s.required_ruby_version     = ">= 2.2.2"
  s.required_rubygems_version = ">= 1.8.11"

  s.license = "MIT"

  s.author   = "Ken Jenney"
  s.email    = "me@kenjenney.com"
  s.homepage = "http://farmstead.kenjenney.com"

  s.files = ["README.md"]

  s.add_dependency "bundler",         ">= 1.3.0"
end
