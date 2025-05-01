require 'rails/generators/base'

module SkeletonGenerator
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    desc 'skeleton core file structure.'
    def generate_initalize_file
      initializer 'skeleton.rb', %(require 'skeleton_generator')
    end

    def copy_docker_files
      copy_file 'Dockerfile.dev'
      copy_file 'compose.dev.yml'
      readme 'doc/docker.md'
    end

    def copy_system_files
      copy_file 'Makefile'
      copy_file 'Dangerfile'
      copy_file 'Procfile.dev'
    end

    def copy_rubocop_files
      run 'touch .rubocop.yml'
      copy_file '.rubocop.skeleton.yml'
      append_file '.rubocop.yml', %(inherit_from: .rubocop.skeleton.yml\n)
    end

    def generate_dot_env
      copy_file '.env.example'
    end

    def extend_dot_github
      directory '.github'
    end

    def extend_gitignore_file
      run 'touch .gitignore'
      append_file '.gitignore', %(vendor/bundle\n)
      append_file '.gitignore', %(/public/packs\n)
      append_file '.gitignore', %(/public/packs-test\n)
      append_file '.gitignore', %(/node_modules\n)
      append_file '.gitignore', %(.env\n)
      append_file '.gitignore', %(.DS_Store\n)
      append_file '.gitignore', %(/yarn-error.log\n)
      append_file '.gitignore', %(coverage/\n)
    end

    def extend_required_root_gemfile
      run 'touch Gemfile'
      gem 'foreman'
      gem 'rack-cors'
      gem 'global'
      gem 'sentry-rails'
      gem 'kaminari'
      gem 'ransack'
    end

    def extend_webapp_root_gemfile
      gem 'slim-rails'
    end

    def extend_skeleton_gemfile
      gem 'service_generator', github: 'departure-inc/service-generator'
      gem 'form_generator', github: 'departure-inc/form-generator'
      gem 'batch_generator', github: 'departure-inc/batch-generator'
      gem 'view_model_generator', github: 'departure-inc/view_model-generator'
      gem 'admin_generator', github: 'departure-inc/admin-generator'
    end

    def extend_groups_gemfile
      gem_group :development, :test do
        gem 'dotenv-rails'
        gem 'rubocop-performance', require: false
        gem 'factory_bot_rails'
        gem 'rspec-rails'
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

    def copy_config_database_file
      # copy_file 'config/database.yml'
      # config/database.ymlのdefaultセクションの設定を変更する
      gsub_file 'config/database.yml', /default: &default\n/, <<~YAML
        default: &default
          adapter: postgresql
          encoding: unicode
          pool: 5
          host: <%= ENV.fetch('APP_DATABASE_HOST') { 'db' } %>
          username: <%= ENV.fetch('APP_DATABASE_USERNAME') { 'postgres' } %>
          password: <%= ENV.fetch('APP_DATABASE_PASSWORD') { 'password' } %>
          port: <%= ENV.fetch('APP_DATABASE_PORT') { 5432 } %>
          url: <%= ENV['DATABASE_URL'] %>
      YAML

      append_file 'config/database.yml', <<~YAML
        staging:
          <<: *default
          database: app_name_staging
      YAML
    end

    def copy_config_files
      directory 'config/global'
      copy_file 'config/initializers/0_exception.rb'
      copy_file 'config/initializers/global.rb'
      copy_file 'config/initializers/cors.rb'
      copy_file 'config/initializers/raven.rb'
    end

    def download_locale_files
      get 'https://raw.githubusercontent.com/svenfuchs/rails-i18n/master/rails/locale/ja.yml', 'config/locales/ja.yml'
      get 'https://raw.githubusercontent.com/svenfuchs/rails-i18n/master/rails/locale/en.yml', 'config/locales/en.yml'
    end

    def copy_seed_files
      directory 'db/seeds'
      copy_file 'db/seeds.rb', force: true
    end

    def extend_routes
      directory 'config/routes'

      route %(root to: 'welcome#index')
      route 'draw :base'
    end

    def generate_root_resources
      directory 'app/controllers'
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

      remove_file 'app/views/layouts/application.html.erb'
      remove_file 'app/views/layouts/mailer.html.erb'
      remove_file 'app/views/layouts/mailer.text.erb'
    end

    def extend_application_config
      log :extend, 'config/application.rb'
      application application_config_content
    end

    def extend_environments_config
      copy_file 'config/environments/staging.rb'

      log :extend, 'config/environments/production.rb'
      application(nil, env: :production) do
        mail_config_content
      end

      log :extend, 'config/environments/development.rb'
      application(nil, env: :development) do
        mail_config_content
      end
    end

    def extend_heroku_config
      return unless yes?('Would you like to heroku? (y/N)')

      copy_file 'Procfile'
      readme 'doc/heroku.md'
    end

    def extend_digitalocean_config
      return unless yes?('Would you like to digitalocean? (y/N)')

      readme 'doc/digitalocean.md'
    end

    def extend_datadog_config
      return unless yes?('Would you like to datadog? (y/N)')

      gem 'ddtrace'
      copy_file 'config/initializers/datadog.rb'
      Bundler.with_original_env { in_root { run 'bundle' } }
    end

    def bundle_generator_rspec
      return unless recommended?('Would you like to rspec?')

      Bundler.with_original_env { in_root { run 'bundle' } }
      generate 'rspec:install'
    end

    def bundle_generator_bullet
      return unless recommended?('Would you like to bullet?')

      Bundler.with_original_env { in_root { run 'bundle' } }
      generate 'bullet:install'
    end

    def bundle_importmap
      return unless recommended?('Would you like to importmap?')

      Bundler.with_original_env { in_root { run 'bundle' } }
      rails_command 'importmap:install'
    end

    def bundle_stimulus
      return unless recommended?('Would you like to hotwire and stimulus?')

      Bundler.with_original_env { in_root { run 'bundle' } }
      rails_command 'turbo:install'
      rails_command 'stimulus:install'
    end

    def bundle_css
      return unless recommended?('Would you like to tailwindcss?')

      Bundler.with_original_env { in_root { run 'bundle' } }
      rails_command 'tailwindcss:install'
    end

    def output_readme
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
          g.jbuilder false
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

    def recommended?(message)
      answer = ask("#{message} (Y/n)")
      answer.strip.empty? || answer.downcase.start_with?('y')
    end
  end
end
