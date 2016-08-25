require "helloworld_services_pb"

class GreeterService < Helloworld::Greeter::Service
  def say_hello(hello_request, _call)
    HelloResponse.new(message: "hello world", seconds_taken: 0.1)
  end
end
