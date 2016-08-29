module ApiServer
  class << self
    def root
      @root || raise("Root is not set")
    end

    def logger
      # TODO: NullLogger as a fallback
      @logger
    end

    def root=(path)
      @root = Pathname.new(path)
    end

    def logger=(logger)
      @logger = logger
    end

    def setup_services(server)
      require "announcements_service"
      server.handle(AnnouncementsService.new)
    end
  end
end
