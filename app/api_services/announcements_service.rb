require "announcements_services_pb"

class AnnouncementsService < API::Announcements::Announcements::Service
  def search(query, _call)
    scope = Announcement.
      most_recent_first

    announcements = scope.
      limit(clamp(query.limit, 1..100)).
      offset([query.offset, 0].max)

    API::Announcements::SearchResult.new(
      total: scope.count,
      hits: AnnouncementsToApiHitsMapper.map_scope(announcements),
    )
  end

  def get(id, _call)
    API::Announcements::LookupResult.new(
      announcement: AnnouncementToApiMapper.map(Announcement.find(id.id))
    )
  rescue ActiveRecord::RecordNotFound
    API::Announcements::LookupResult.new
  end

  private
  def clamp(value, range)
    if value > range.max
      range.max
    elsif value < range.min
      range.min
    else
      value
    end
  end
end
