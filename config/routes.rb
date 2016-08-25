Rails.application.routes.draw do
  get "/" => "greetings#new"
  post "/greet" => "greetings#create"

  # Old API that we're extracting to gRPC
  scope "/api/v1" do
    get "/announcements" => "api/v1/announcements#index"
    get "/announcements/:id" => "api/v1/announcements#show"
  end

  # gRPC
  scope "/api/v2" do
    get "/announcements" => "api/v2/announcements#index"
    get "/announcements/:id" => "api/v2/announcements#show"
  end
end
