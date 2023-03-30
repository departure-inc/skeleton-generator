require Rails.root.join('config/environments/production')
Rails.application.configure do
  config.log_level = :debug
  config.log_tags = [:request_id]
  config.action_controller.asset_host = '//hoge.cloudfront.net'

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { host: 'herokuapps.com', protocol: 'https' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: ENV.fetch('MAIL_SMTP_ADDRESS', 'smtp.sendgrid.net'),
    port: ENV.fetch('MAIL_SMTP_PORT', 587),
    domain: ENV.fetch('MAIL_SMTP_DOMAIN', 'herokuapps.com'),
    authentication: ENV.fetch('MAIL_SMTP_AUTH', 'plain'),
    user_name: ENV.fetch('SENDGRID_USERNAME', 'apikey'),
    password: ENV.fetch('SENDGRID_PASSWORD', 'SG.xxx'),
    enable_starttls_auto: true
  }
  # config.active_job.queue_adapter = :inline
end
