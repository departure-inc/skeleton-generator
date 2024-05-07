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
    respond_to do |format|
      format.html { render template: 'errors/not_found', status: :not_found, layout: 'error' }
      format.json { render json: { code: 'not_found', message: exception.message }, status: :not_found }
    end
  end

  def unauthorized(exception = nil)
    @exception = exception
    respond_to do |format|
      format.html { render template: 'errors/unauthorized', status: :unauthorized, layout: 'error' }
      format.json { render json: { code: 'unauthorized', message: exception.message }, status: :unauthorized }
    end
  end

  def forbidden(exception = nil)
    @exception = exception
    respond_to do |format|
      format.html { render template: 'errors/forbidden', status: :forbidden, layout: 'error' }
      format.json { render json: { code: 'forbidden', message: exception.message }, status: :forbidden }
    end
  end

  def bad_request(exception = nil)
    @exception = exception
    respond_to do |format|
      format.html { render template: 'errors/bad_request', status: :forbidden, layout: 'error' }
      format.json { render json: { code: 'bad_request', message: exception.message }, status: :bad_request }
    end
  end

  def unprocessable_entity(exception = nil)
    @exception = exception
    respond_to do |format|
      format.html { render template: 'errors/unprocessable', status: :unprocessable_entity, layout: 'error' }
      format.json do
        render json: { code: 'unprocessable_entity', message: exception.message }, status: :unprocessable_entity
      end
    end
  end

  def internal_server_error(exception = nil)
    @exception = exception
    Rails.error.report(exception)
    respond_to do |format|
      format.html { render template: 'errors/internal', status: :internal_server_error, layout: 'error' }
      format.json do
        render json: { code: 'internal_server_error', message: exception.message }, status: :internal_server_error
      end
    end
  end
end
