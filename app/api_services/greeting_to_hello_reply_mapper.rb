class GreetingToHelloReplyMapper
  def self.map(greeting)
    new(greeting).map
  end

  def initialize(greeting)
    @greeting = greeting
    @start = Time.now
  end

  def message
    @greeting.message
  end

  def seconds_taken
    Time.now - @start
  end

  def map
    Helloworld::HelloReply.new(
      message: message,
      secondsTaken: seconds_taken,
    )
  end
end
