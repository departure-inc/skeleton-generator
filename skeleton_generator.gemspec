require_relative "lib/skeleton_generator/version"

Gem::Specification.new do |spec|
  spec.name        = "skeleton_generator"
  spec.version     = SkeletonGenerator::VERSION
  spec.authors     = ["kawashima@dptr.jp"]
  spec.email       = ["kawashima@dptr.jp"]
  spec.homepage    = "https://dptr.jp"
  spec.summary     = "Skeleton Structure Generators."
  spec.description = "Skeleton Structure Generators."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/departure-inc/skeleton-generator"
  spec.metadata["changelog_uri"] = "https://github.com/departure-inc/skeleton-generator"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 7.0.4.2"
end
