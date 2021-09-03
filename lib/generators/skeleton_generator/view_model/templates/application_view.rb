require 'active_support/core_ext/module/delegation'
class ApplicationView
  attr_reader :model, :vc

  delegate_missing_to :model

  def initialize(model, view_context = nil)
    @model = model
    @vc = view_context
  end

  def self.collection(models, view_context = nil)
    models.map { |model| new(model, view_context) }
  end
end
