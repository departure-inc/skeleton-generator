class ApplicationBatch
  def self.perform(**args)
    new(args).perform
  end

  def initialize(args)
    @context = args
  end

  def perform
    raise 'no implementation'
  end

  private

  def logger
    Rails.logger
  end
end
