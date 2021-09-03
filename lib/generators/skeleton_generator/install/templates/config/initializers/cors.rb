if defined?(Rack::Cors)
  Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      # origins 'localhost:3000' , 'localhost:8080'
      origins '*'
      resource '*', headers: :any, methods: %i(get post put patch delete options)
    end
  end
end
