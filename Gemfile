source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in skeleton.gemspec.
gemspec

gem 'service_generator', github: 'departure-inc/service-generator', branch: 'v1.0.0'
gem 'batch_generator', github: 'departure-inc/batch-generator', branch: 'v1.0.0'
gem 'form_generator', github: 'departure-inc/form-generator', branch: 'v1.0.0'
gem 'view_model_generator', github: 'departure-inc/view_model-generator', branch: 'v1.0.0'

# To use a debugger
group :development, :test do
  gem 'sqlite3'
  gem 'pry'
  gem 'byebug'
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'rspec'
end
