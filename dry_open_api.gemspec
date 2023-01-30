lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dry_open_api/version"

Gem::Specification.new do |spec|
  spec.name          = "dry_open_api"
  spec.version       = DryOpenApi::VERSION
  spec.authors       = ["Andy Ruck"]
  spec.email         = ["devops@talentplatforms.net"]

  spec.summary       = "Dry-PORO OpenAPI 3.x"
  spec.description   = "It provides a dried PORO of OpenAPI specification."
  spec.homepage      = "https://github.com/talentplatforms/dry_open_api"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 6", "< 8"
  spec.add_runtime_dependency "dry-initializer", "~> 3.0"

  spec.add_development_dependency "bundler", "~> 2.0.2", ">= 2.0.2"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "bump"
end
