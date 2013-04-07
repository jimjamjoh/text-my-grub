class SmsResponder
  def self.respond(messageables)
    to_TwiML(messageables)
  end

  def self.respond_to_unrecognized_input
     to_TwiML("I'm sorry, I didn't understand your request")
  end

  private

  def self.to_TwiML(messageables)
    Twilio::TwiML::Response.new do |response|
      [messageables].flatten.each {|messageable| response.Sms wrap_as_cdata(messageable.to_s)}
    end.text
  end

  private

  def self.wrap_as_cdata(message)
    "<![CDATA[#{message}]]>"
  end
end