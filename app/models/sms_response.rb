class SmsResponse

  def initialize response
    @response = response
  end

  def to_xml
    "<Response><Sms>#{@response}</Sms></Response>"
  end

  def self.unrecognized_input
    SmsResponse.new("I'm sorry, I didn't understand your request")
  end
end