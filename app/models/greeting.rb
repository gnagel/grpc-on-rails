class Greeting
  def self.construct(name, informal: false)
    message = if informal
      "Hey, #{name}! What's up?"
    else
      "Hello, #{name}."
    end

    new(message: message, informal: informal)
  end

  attr_reader :message, :informal

  def initialize(message:, informal:)
    @message = message
    @informal = informal
  end

  # Let's pretend this was part of a JSON API before!
  def to_json
    {
      message: message,
      informal: informal,
    }
  end
end
