lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "farmstead/version"

Gem::Specification.new do |spec|
  spec.name          = "farmstead"
  spec.version       = Farmstead::VERSION
  spec.authors       = ["Ken Jenney"]
  spec.email         = ["mastermindg@gmail.com"]

  spec.summary       = "Farmstead is a modular data pipeline platform."
  spec.description   = "Farmstead is a modular data pipeline platform. Farmstead makes creating and deploying a fully-functional data pipeline a snap. It is built on top of Rails/Ruby and uses Docker. This combination allows for a super-fast deployment and prototyping process."
  spec.homepage      = "https://github.com/mastermindg/farmstead"
  spec.license       = "MIT"

  spec.required_ruby_version     = ">= 2.4.1"
  spec.required_rubygems_version = ">= 2.6.11"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.executables   = ['farmstead']
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 0.20.0"
  spec.add_dependency "os", "~> 1.0"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
