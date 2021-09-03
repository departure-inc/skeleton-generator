module AppHealthCheck
  extend ActiveSupport::Concern

  included do
    def ping
      result = AppErrorHandler.with_io_error_handling do
        ActiveRecord::Base.connection.execute('SELECT 1')
      end

      if result.try(:handled?)
        render json: result.to_response, status: :internal_server_error
      else
        head :ok
      end
    end
  end
end
