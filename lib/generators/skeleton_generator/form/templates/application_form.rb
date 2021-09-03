class ApplicationForm
  def self.validate!(**args)
    new(args).validate
  end

  def validate
    raise 'no implementation'
  end
end
