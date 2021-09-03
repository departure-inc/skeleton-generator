#
# @example
# include AppErrorHandler
#
# def create
#   result = AppErrorHandler.with_io_error_handling do
#     service = UpsertUserService.new(user: current_user)
#     service.invoke!
#     service.result
#   end
#
#   if result.try(:handled?)
#     # error handling code
#   else
#     # success code
#   end
# end
#

class AppErrorHandler
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :exception

  def self.with_io_error_handling
    yield
  rescue ServiceNotExecuted,
         AuthenticatedError,
         ActiveRecord::RecordNotFound,
         ActiveRecord::RecordInvalid,
         ActiveModel::ValidationError,
         ForbiddenError,
         PG::ConnectionBad,
         ActiveRecord::NoDatabaseError,
         RuntimeError => e
    Sentry.capture_exception(e)
    Rails.logger.error(e)
    new(exception: e)
  end

  def handled?
    exception.present?
  end

  def to_response
    {
      code: exception.try(:code) || 'unknown',
      class_name: exception.try(:class) || 'unknown',
      message: exception.try(:message) || 'unknown',
      fields: []
    }
  end
end
