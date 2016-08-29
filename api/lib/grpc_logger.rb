module GRPC
  def self.logger=(logger)
    @logger = logger
  end

  def self.logger
    @logger || LOGGER
  end
end

