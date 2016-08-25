class AnnouncementToApiHitMapper < Delegator
  def self.map_scope(scope)
    scope.select(:id, :title, :author_name, :published_at).each do |hit|
      map(hit)
    end
  end

  def self.map(announcement)
    new(announcement).map
  end

  def map
    API::Announcements::SearchResult::Hit.new(
      id: id,
      title: title,
      authorName: author_name,
      publishedAt: published_at.to_i,
    )
  end
end
