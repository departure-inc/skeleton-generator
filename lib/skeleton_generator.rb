require 'skeleton_generator/version'
require 'skeleton_generator/railtie'

module SkeletonGenerator
  class << self
    def configure
      yield self if block_given?
    end
  end
end
