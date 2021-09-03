source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in skeleton.gemspec.
gemspec

group :development do
  gem 'sqlite3'
  gem 'pry'
end

# To use a debugger
group :development, :test do
  gem 'byebug'
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
end

gem 'rspec', group: [:test]
