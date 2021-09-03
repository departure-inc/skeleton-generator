if defined?(Sentry)
  Sentry.init do |config|
    config.dsn = ENV['RAVEN_DSN'] # 'http://public@example.com/project-id'
  end
end
