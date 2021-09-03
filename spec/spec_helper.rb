require 'rails'

ENV['RAILS_ENV'] ||= 'test'
abort('The Rails environment is running in production mode!') unless Rails.env.test?
RSpec.configure do |config|
  # add config
end
