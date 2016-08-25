require "greeter_service"
require "logger"

module GRPC
  def self.logger=(logger)
    @logger = logger
  end

  def self.logger
    @logger || LOGGER
  end
end

class GrpcServer
  def initialize(argv)
    @argv = argv
  end

  def start
    GRPC.logger = logger

    s = GRPC::RpcServer.new
    s.add_http2_port(listen_address, :this_port_is_insecure)
    logger.info "Running insecurely on #{listen_address}"

    s.handle(GreeterService.new)
    s.run_till_terminated
  end

  private
  def logger
    @logger ||= build_logger
  end

  def build_logger
    logger = Logger.new(log_device)
    logger.level = log_level
    logger
  end

  def log_device
    STDOUT
  end

  def log_level
    # TODO: read from @argv by parsing arguments
    Logger::INFO
  end

  def listen_address
    "#{bind_ip}:#{port}"
  end

  def bind_ip
    # TODO: read from @argv by parsing arguments
    ENV.fetch("bind", "127.0.0.1")
  end

  def port
    # TODO: read from @argv by parsing arguments
    ENV.fetch("port", 13_337).to_i
  end
end
