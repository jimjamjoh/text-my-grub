class TwilioResponder
  def self.respond(messageables)
    response_xml = ''
    messageables.each do |messageable|
      response_xml += "<Sms>#{messageable}</Sms>"
    end
    wrapper(response_xml)
  end

  def self.respond_to_unrecognized_input
     wrapper("<Sms>I'm sorry, I didn't understand your request</Sms>")
  end

  private

  def self.wrapper(response_xml)
    "<Response>#{response_xml}</Response>"
  end
end