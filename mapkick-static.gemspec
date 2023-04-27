require_relative "lib/mapkick/static/version"

Gem::Specification.new do |spec|
  spec.name          = "mapkick-static"
  spec.version       = Mapkick::Static::VERSION
  spec.summary       = "Create beautiful static maps with one line of Ruby"
  spec.homepage      = "https://github.com/ankane/mapkick-static"
  spec.license       = "MIT"

  spec.author        = "Andrew Kane"
  spec.email         = "andrew@ankane.org"

  spec.files         = Dir["*.{md,txt}", "{lib}/**/*"]
  spec.require_path  = "lib"

  spec.required_ruby_version = ">= 3"
end
