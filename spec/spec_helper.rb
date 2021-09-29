require 'rails'

ENV['RAILS_ENV'] ||= 'test'
abort('The Rails environment is running in production mode!') unless Rails.env.test?
require 'rails/generators'
require 'skeleton_generator'
Dir[File.join(File.dirname(__FILE__), '../lib/generators/skeleton_generator/*/*.rb')].each { |f| require f }
RSpec.configure do |config|
  # add config
end
