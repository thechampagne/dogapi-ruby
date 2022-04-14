# frozen_string_literal: true

require_relative "lib/dogceo/version"

Gem::Specification.new do |spec|
  spec.name          = "dogceo"
  spec.version       = Dogceo::VERSION
  spec.authors       = ["XXIV"]

  spec.summary       = "Dog API client"
  spec.description   = "Dog API client"
  spec.homepage      = "https://github.com/thechampagne/dogapi-ruby"
  spec.license = 'Apache-2.0'
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/thechampagne/dogapi-ruby"

  spec.files = Dir["lib/**/*.rb", "LICENSE", "README.md"]
  spec.require_paths = ["lib"]
end