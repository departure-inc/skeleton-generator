# Skeleton Generator
skeleton structure generators libraries.

## Usage
How to use my plugin.

initial core file placement.
```bash
$ bundle exec rails g skeleton_generator:install
```

dependency generator command.
```bash
$ bundle exec rails g service CreateThing
$ bundle exec rails g batch ImportThing
$ bundle exec rails g form Thing
$ bundle exec rails g view_model Thing
```

## Installation
Add this line to your application's Gemfile:


```ruby
# Gemfile
ruby '3.3.1'
gem 'rails', '~> 7.1.3', '>= 7.1.3.2'

gem 'skeleton_generator', github: 'departure-inc/skeleton-generator'
```

And then execute:
```bash
$ bundle
```

## Contributing
1. Find a project you want to contribute to
2. Fork it
3. Clone it to your local system
4. Make a new branch
5. Make your changes
6. Push it back to your repo
7. Click the Compare & pull request button
8. Click Create pull request to open a new pull request

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
