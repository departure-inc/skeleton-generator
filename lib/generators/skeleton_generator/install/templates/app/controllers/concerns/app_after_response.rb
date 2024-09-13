#
# @example
# include AppAfterResponse
#
# def create
#   after_response do
#     do_something
#     Rails.logger.info('after_response')
#   end
#
#   render json: 'success', status: :ok
# end
#
module AppAfterResponse
  extend ActiveSupport::Concern

  included do
    def after_response(&block)
      request.env['rack.after_reply'] ||= []
      request.env['rack.after_reply'] << block
    end
  end
end
