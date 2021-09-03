require Rails.root.join('config/environments/production')
Rails.application.configure do
  config.log_level = :debug
  config.log_tags = [:request_id]
  config.action_controller.asset_host = '//hoge.cloudfront.net'

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
  # config.active_job.queue_adapter = :inline
end
