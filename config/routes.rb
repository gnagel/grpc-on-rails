Rails.application.routes.draw do
  get "/" => "greetings#new"
  post "/greet" => "greetings#create"

  scope "/api/v1" do
    get "/announcements" => "api/v1/announcements#index"
    get "/announcements/:id" => "api/v1/announcements#show"
  end
end
