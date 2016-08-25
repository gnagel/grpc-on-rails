class Api::V1::AnnouncementsController < ApplicationController
  def index
    @announcements = Announcement.most_recent_first.limit(params.fetch(:limit, 20))
    render json: @announcements
  end

  def show
    @announcement = Announcement.find(params[:id])
    render json: @announcement
  end

  private
  def limit
    clamp(params.fetch(:limit, 20).to_i, 1..100)
  end

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
