# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "xcode_pristine/version"

Gem::Specification.new do |spec|
  spec.name          = "xcode-pristine"
  spec.version       = XcodePristine::Version::CURRENT
  spec.authors       = ["Stewart Gleadow"]
  spec.email         = ["sgleadow@gmail.com"]

  spec.summary       = %q{Ensure your Xcode project is clean of any unwanted build settings.}
  spec.description   = %q{When using xcconfig files to manage Xcode project build settings, you want to make sure your Xcode project doesn't override any of those build settings in the project file. This gem uses the xcodeproj gem to read the project file and check there aren't any unwanted build settings that can creep in by accident.}
  spec.homepage      = "https://github.com/sgleadow/xcode-pristine"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "xcodeproj", "~> 1.5"
end
