require "announcements_services_pb"

# Require from Rails app
require "announcement"

require "announcement/to_api_hit_mapper"
require "announcement/to_api_announcement_mapper"

class AnnouncementsService < GOR::Announcements::Announcements::Service
  def search(query, _call)
    scope = Announcement.
      most_recent_first

    announcements = scope.
      limit(clamp(query.limit, 1..100)).
      offset([query.offset, 0].max)

    GOR::Announcements::SearchResult.new(
      total: scope.count,
      hit: Announcement::ToApiHitMapper.map_scope(announcements),
    )
  end

  def get(id, _call)
    GOR::Announcements::LookupResult.new(
      announcement: Announcement::ToApiAnnouncementMapper.map(Announcement.find(id.id))
    )
  rescue ActiveRecord::RecordNotFound
    GOR::Announcements::LookupResult.new
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
