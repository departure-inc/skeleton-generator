source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in skeleton.gemspec.
gemspec

gem 'service_generator', github: 'departure-inc/service-generator'
gem 'batch_generator', github: 'departure-inc/batch-generator'
gem 'form_generator', github: 'departure-inc/form-generator'
gem 'view_model_generator', github: 'departure-inc/view_model-generator'

# To use a debugger
group :development, :test do
  gem 'sqlite3'
  gem 'pry'
  gem 'byebug'
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rubocop-performance'
  gem 'rubocop-rspec'
  gem 'rspec'
  gem 'generator_spec'
end
