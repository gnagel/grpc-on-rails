class AnnouncementToApiMapper < Delegator
  def self.map(announcement)
    new(announcement).map
  end

  def map
    API::Announcements::Announcement.new(
      id: id,
      title: title,
      body: body,
      authorName: author_name,
      publishedAt: published_at.to_i,
    )
  end
end
