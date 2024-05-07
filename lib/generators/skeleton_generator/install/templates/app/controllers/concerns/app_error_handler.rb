#
# @note エラーハンドリングを拡張するときに利用してください
# @example
# include AppErrorHandler
#
# def create
#   result = AppErrorHandler.handle do
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
# @deprecated Rails7.1以降は`Rails.error.handle`を使用してください
# @example
# def create
#   result = Rails.error.handle do
#     response = UpsertUserService.call(user: current_user)
#     response.result
#   end
#
#   render json: result.object, status: result.status
# end
#

class AppErrorHandler
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :exception

  def self.handle
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
    Rails.error.report(e)
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
