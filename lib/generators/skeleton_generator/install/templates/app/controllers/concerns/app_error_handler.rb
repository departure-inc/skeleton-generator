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
#   if result.handled?
#     # error handling code
#     render json: result.to_response, status: :internal_server_error
#   else
#     # success code
#     render json: result.object, status: :ok
#   end
# end
#
# @deprecated Rails7.1以降は状況に応じて`Rails.error.handle`を使用してください
# @example
# def create
#   result = Rails.error.handle do
#     response = UpsertUserService.call(user: current_user)
#     response.result
#   end
#
#   render json: result, status: :ok
# end
#

class AppErrorHandler
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :exception
  attribute :object

  def self.handle
    object = yield
    new(exception: nil, object:)
  rescue ServiceNotExecuted,
         AuthenticatedError,
         ActiveRecord::StatementInvalid,
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
