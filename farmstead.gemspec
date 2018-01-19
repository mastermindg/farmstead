lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "farmstead/version"

Gem::Specification.new do |spec|
  spec.name          = "farmstead"
  spec.version       = Farmstead::VERSION
  spec.authors       = ["Ken Jenney"]
  spec.email         = ["mastermindg@gmail.com"]

  spec.summary       = "Farmstead is a modular data pipeline platform."
  spec.description   = "Farmstead is a modular data pipeline platform. Farmstead makes creating and deploying a fully-functional data pipeline a snap. Farmstead uses containers to encapsulate the middleware which allows for a super-fast deployment and prototyping process."
  spec.homepage      = "https://github.com/mastermindg/farmstead"
  spec.license       = "MIT"

  spec.required_ruby_version     = ">= 2.4.1"
  spec.required_rubygems_version = ">= 2.6.11"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.executables   = ['farmstead']
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "thor", "~> 0.20.0"
  spec.add_runtime_dependency "os", "~> 1.0"
  spec.add_runtime_dependency "ruby-kafka", "~> 0.5.1"
  spec.add_runtime_dependency "mysql2", "~> 0.4.10"
  spec.add_runtime_dependency "nokogiri", "~> 1.8"
  spec.add_runtime_dependency "mechanize", "~> 2.7"
  spec.add_runtime_dependency "httparty", "~> 0.15.6"
  spec.add_runtime_dependency "sinatra", "~> 2.0.0"

  spec.add_development_dependency "dotenv", "~> 0.11.1"
  spec.add_development_dependency "listen", "~> 3.0"
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
