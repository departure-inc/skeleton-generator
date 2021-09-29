module AppErrorResponder
  extend ActiveSupport::Concern

  included do
    if Rails.env.production? || Rails.env.test?
      rescue_from Exception, with: :internal_server_error
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity?
      rescue_from ActionController::RoutingError, with: :not_found
      rescue_from AuthenticatedError, with: :unauthorized
      rescue_from ForbiddenError, with: :forbidden
      rescue_from ActiveModel::ValidationError, with: :unprocessable_entity
      rescue_from ServiceNotExecuted, with: :unprocessable_entity
    end
  end

  def not_found(exception = nil)
    @exception = exception
    render template: 'errors/not_found', status: :not_found, layout: 'error'
  end

  def unauthorized(exception = nil)
    @exception = exception
    render template: 'errors/unauthorized', status: :unauthorized, layout: 'error'
  end

  def forbidden(exception = nil)
    @exception = exception
    render template: 'errors/forbidden', status: :forbidden, layout: 'error'
  end

  def bad_request(exception = nil)
    @exception = exception
    render template: 'errors/bad_request', status: :forbidden, layout: 'error'
  end

  def unprocessable_entity(exception = nil)
    @exception = exception
    render template: 'errors/unprocessable', status: :unprocessable_entity, layout: 'error'
  end

  def internal_server_error(exception = nil)
    @exception = exception
    Sentry.capture_exception(exception)
    render template: 'errors/internal', status: :internal_server_error, layout: 'error'
  end
end
