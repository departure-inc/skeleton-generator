#
# @example
# curl -i http://localhost:3000/_healthcheck
# > HTTP/1.1 200 OK
#
# @note RailsのHealthControllerを利用する場合は、以下のように設定する
# edit config/routes.rb
# get "up" => "rails/health#show", as: :rails_health_check
# curl -i http://localhost:3000/up
#
module AppHealthCheck
  extend ActiveSupport::Concern

  included do
    def ping
      result = AppErrorHandler.handle do
        ActiveRecord::Base.connection.execute('SELECT 1')
      end

      if result.handled?
        render json: result.to_response, status: :internal_server_error
      else
        head :ok
      end
    end
  end
end
