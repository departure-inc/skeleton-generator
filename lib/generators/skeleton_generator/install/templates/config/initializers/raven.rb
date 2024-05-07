if defined?(Sentry)
  Sentry.init do |config|
    config.dsn = ENV.fetch('RAVEN_DSN', 'http://public@example.com/project-id')
    config.rails.report_rescued_exceptions = true
    config.rails.register_error_subscriber = true
  end
end
