class SmsResponse

  def initialize response
    @response = response
  end

  def to_xml
    "<Sms>#{@response}</Sms>"
  end

  def self.unrecognized_input
    SmsResponse.new("I'm sorry, I didn't understand your request")
  end
end