require "helloworld_services_pb"

class GreetingsController < ApplicationController
  def new
    render json: {instructions: "POST a name to /greet!"}
  end

  def create
    hello_request = Helloworld::HelloRequest.new(**hello_request_params)
    client = Helloworld::Greeter::Stub.new(ENV.fetch("API_URL"), :this_channel_is_insecure)
    hello_response = client.say_hello(hello_request)
    render json: {
      message: hello_response.message,
      time_taken: hello_response.secondsTaken,
    }
  end

  private
  def hello_request_params
    hello_request = params.require(:hello_request)
    {
      name: hello_request.require(:name),
      informal: hello_request.fetch(:informal, false),
    }
  end
end
