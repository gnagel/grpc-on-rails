require "delegate"

class Announcement::ToApiAnnouncementMapper < DelegateClass(Announcement)
  def self.map_scope(scope)
    scope.map { |hit| map(hit) }
  end

  def self.map(announcement)
    new(announcement).map
  end

  def initialize(announcement)
    super(announcement)
  end

  def publishedAt
    published_at.to_i
  end

  def map
    GOR::Announcements::Announcement.new(
      id: id,
      title: title,
      authorName: author_name,
      publishedAt: publishedAt,
      body: body,
    )
  end
end
