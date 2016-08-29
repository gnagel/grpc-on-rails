require "delegate"

class Announcement::ToApiHitMapper < DelegateClass(Announcement)
  def self.map_scope(scope)
    scope.select(:id, :title, :author_name, :published_at).map do |hit|
      map(hit)
    end
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
    GOR::Announcements::SearchResult::Hit.new(
      id: id,
      title: title,
      authorName: author_name,
      publishedAt: publishedAt,
    )
  end
end
