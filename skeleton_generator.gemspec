require_relative "lib/skeleton_generator/version"
version = SkeletonGenerator::VERSION

Gem::Specification.new do |spec|
  spec.name        = "skeleton_generator"
  spec.version     = version
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

  spec.add_dependency "rails", ">= 7.0.4.3"
  # spec.add_runtime_dependency "service_generator" # , ">= 1.0.0"
  # spec.add_runtime_dependency "form_generator" # , ">= 1.0.0"
  # spec.add_runtime_dependency "batch_generator" # , ">= 1.0.0"
  # spec.add_runtime_dependency "view_model_generator" # , ">= 1.0.0"
end
