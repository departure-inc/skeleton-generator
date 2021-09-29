require 'spec_helper'

RSpec.describe SkeletonGenerator do
  describe '::VERSION' do
    it { expect(SkeletonGenerator::VERSION).not_to be_nil }
  end
end
