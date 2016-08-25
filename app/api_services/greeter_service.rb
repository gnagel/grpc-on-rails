require "helloworld_services_pb"

class GreeterService < Helloworld::Greeter::Service
  def say_hello(hello_request, _call)
    Helloworld::HelloReply.new(message: "hello world", secondsTaken: 0.1)
  end
end
