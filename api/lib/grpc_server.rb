require "logger"

require "grpc_logger"

class GrpcServer
  attr_reader :argv, :handler

  def initialize(argv, handler)
    @argv = argv
    @handler = handler
  end

  def run
    handler.logger = logger
    GRPC.logger = logger
    if defined?(Rails)
      Rails.logger = logger
      ActiveRecord::Base.logger = logger
    end

    s = GRPC::RpcServer.new
    s.add_http2_port(listen_address, :this_port_is_insecure)

    handler.setup_services(s)

    logger.info "Running insecurely on #{listen_address}"
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
