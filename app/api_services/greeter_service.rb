require "helloworld_services_pb"
require "greeting"
require "greeting_to_hello_reply_mapper"

class GreeterService < Helloworld::Greeter::Service
  def say_hello(hello_request, _call)
    greeting = Greeting.construct(hello_request.name, informal: hello_request.informal)
    GreetingToHelloReplyMapper.map(greeting)
  end
end
