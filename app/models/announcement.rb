class Announcement < ApplicationRecord
  scope :most_recent_first, ->{ reorder("published_at DESC").where("published_at < ?", Time.current) }
end
