class AnnouncementsStore
  def initialize(url = ENV.fetch("API_URL"))
    @stub = GOR::Announcements::Announcements::Stub.new(url, :this_channel_is_insecure)
  end

  def search(limit: 10, offset: 0)
    stub.search(GOR::Announcements::Query.new(limit: limit, offset: offset))
  end

  def find(id:)
    result = stub.get(GOR::Announcements::Id.new(id: id))
    result.announcement or raise "Could not find announcement with id #{id}"
  end

  private
  attr_reader :stub
end
