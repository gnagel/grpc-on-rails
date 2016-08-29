require "announcements_services_pb"

class Api::V2::AnnouncementsController < ApplicationController
  def index
    @announcements = store.search(limit: limit, offset: offset)
    render json: @announcements.to_json
  end

  def show
    @announcement = store.find(id: params[:id].to_i)
    render json: @announcement.to_json
  rescue => error
    # This should obviously use a more proper error type/class in a real app
    render json: {code: 404, message: error.to_s}, status: :not_found
  end

  private
  def store
    @store ||= AnnouncementsStore.new
  end

  def limit
    clamp(params.fetch(:limit, 20).to_i, 1..100)
  end

  def offset
    [params.fetch(:offset, 0).to_i, 0].max
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
