require 'rails/generators/base'

module SkeletonGenerator
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    desc 'skeleton core file structure.'
    def generate_initalize_file
      initializer 'skeleton.rb', %(require 'skeleton_generator')
    end

    def copy_system_files
      copy_file 'Dockerfile', skip: true
      copy_file 'docker-compose.yml', skip: true
      copy_file 'Makefile'
      copy_file 'Dangerfile'
      copy_file 'Procfile'
      copy_file 'Procfile.dev'
    end

    def copy_dot_files
      copy_file '.rubocop.skeleton.yml'
      copy_file '.rubocop.yml'
      copy_file '.slim-lint.yml'
      copy_file '.eslintrc.json'
      copy_file '.stylelintrc.json'
    end

    def generate_dot_env
      copy_file '.env.example'
    end

    def extend_dot_github
      directory '.github'
    end

    def extend_gitignore_file
      append_file '.gitignore', %(vendor/bundle\n)
      append_file '.gitignore', %(/public/packs\n)
      append_file '.gitignore', %(/public/packs-test\n)
      append_file '.gitignore', %(/node_modules\n)
      append_file '.gitignore', %(.env\n)
      append_file '.gitignore', %(.DS_Store\n)
      append_file '.gitignore', %(/yarn-error.log\n)
      append_file '.gitignore', %(coverage/\n)
    end

    def extend_root_gemfile
      gem 'foreman'
      gem 'dotenv-rails'
      gem 'rack-cors'
      gem 'global'
      gem 'slim-rails'
      gem 'sentry-ruby'
      gem 'kaminari'
    end

    def extend_groups_gemfile
      gem_group :development, :test do
        gem 'brakeman', require: false
        gem 'rubocop-rails'
        gem 'rubocop-rspec'
        gem 'factory_bot_rails'
        gem 'rspec-rails'
        gem 'slim_lint', require: false
      end
    end

    def extend_group_development_gemfile
      gem_group :development do
        gem 'bullet'
      end
    end

    def extend_group_test_gemfile
      gem_group :test do
        gem 'simplecov', require: false
        gem 'danger'
        gem 'danger-todoist'
        gem 'danger-lgtm'
        gem 'danger-rubocop'
      end
    end

    def copy_config_files
      copy_file 'config/database.yml', force: true
      directory 'config/global'
      directory 'config/initializers', force: true
    end

    def copy_seed_files
      directory 'db/seeds'
      copy_file 'db/seeds.rb', force: true
    end

    def extend_routes
      directory 'config/routes'

      route %(root to: 'general#index')
      route 'draw :base'
    end

    def extend_controller_files
      directory 'app/controllers/concerns'
      inject_into_file 'app/controllers/application_controller.rb',
                       %(  include AppErrorResponder\n),
                       after: /class ApplicationController.*\n/
      inject_into_file 'app/controllers/application_controller.rb',
                       %(  include AppHealthCheck\n),
                       after: /class ApplicationController.*\n/
    end

    def copy_view_files
      directory 'app/views'
    end

    def extend_application_config
      log('prepend config/application.rb')
      application application_config_content
    end

    def extend_environments_config
      copy_file 'config/environments/staging.rb'

      log('prepend config/environments/production.rb')
      application(nil, env: :production) do
        mail_config_content
      end

      log('prepend config/environments/development.rb')
      application(nil, env: :development) do
        mail_config_content
      end
    end

    def generators
      if yes?('Would you like to bundle? (y/N)')
        Bundler.with_clean_env { in_root { run 'bundle' } }
        generate 'rspec:install'
        generate 'bullet:install'
      end
      readme 'README'
    end

    private

    def application_config_content
      <<~CODE
        config.time_zone = 'Tokyo'
        config.active_record.default_timezone = :local
        config.i18n.default_locale = :ja
        config.generators do |g|
          g.stylesheets false
          g.javascripts false
          g.helper false
          g.assets false
          g.test_framework :rspec, view_specs: false, helper_specs: false, routing_specs: false
          g.fixture_replacement :factory_bot, dir: 'spec/factories'
        end
      CODE
    end

    def mail_config_content
      <<-CODE
        config.action_mailer.raise_delivery_errors = true
        config.action_mailer.default_url_options = { host: 'herokuapps.com', protocol: 'https' }
        config.action_mailer.delivery_method = :smtp
        config.action_mailer.smtp_settings = {
          address: ENV['MAIL_SMTP_ADDRESS'],
          port: ENV['MAIL_SMTP_PORT'],
          domain: ENV['MAIL_SMTP_DOMAIN'],
          authentication: ENV['MAIL_SMTP_AUTH'],
          user_name: ENV['SENDGRID_USERNAME'],
          password: ENV['SENDGRID_PASSWORD'],
          enable_starttls_auto: true
        }
      CODE
    end
  end
end
