if defined?(Sentry)
  Sentry.init do |config|
    config.dsn = ENV.fetch('RAVEN_DSN', 'http://public@example.com/project-id')
  end
end
