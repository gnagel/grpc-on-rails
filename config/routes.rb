Rails.application.routes.draw do
  get "/" => "greetings#new"
  post "/greet" => "greetings#create"
end
