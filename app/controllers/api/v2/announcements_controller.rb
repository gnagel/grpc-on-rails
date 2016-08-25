require "announcements_services_pb"

class Api::V2::AnnouncementsController < ApplicationController
  def index
    @announcements = stub.search(API::Announcements::Query.new(limit: limit))
    render json: @announcements
  end

  def show
    result = stub.get(API::Announcements::Id.new(id: params[:id].to_i))
    @announcement = result.announcement
    if @announcement
      render json: @announcement
    else
      render json: {code: 404, message: "Not found"}, status: :not_found
    end
  end

  private
  def stub
    @stub ||= API::Announcements::Announcements::Stub.new(ENV.fetch("API_URL"), :this_channel_is_insecure)
  end

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
