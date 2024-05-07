require 'spec_helper'
require 'generator_spec'
require 'generators/skeleton_generator/install/install_generator'

RSpec.describe SkeletonGenerator::InstallGenerator, type: :generator do
  destination File.expand_path('../../../../tmp/app', __dir__)
  arguments %w(install --skip)

  before do
    prepare_destination
    run_generator
  end

  context 'when check files' do
    it 'creates a skeleton.rb file' do
      assert_file 'config/initializers/skeleton.rb', /require 'skeleton_generator'/
    end
  end
end
