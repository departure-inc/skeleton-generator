class ApplicationService
  def self.call(**args)
    new(args).call
  end

  def initialize(args)
    @context = OpenStruct.new(args)
  end

  def call
    raise 'no implementation'
  end

  private

  def logger
    Rails.logger
  end
end
