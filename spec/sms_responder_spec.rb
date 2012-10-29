require 'spec_helper'

describe SmsResponder do
  describe '#self.respond' do
    it 'should contained the stringified messages' do
      first_messageable = random_string
      second_messageable = random_string

      response = SmsResponder.respond([first_messageable, second_messageable])

      response.should include(first_messageable.to_s)
      response.should include(second_messageable.to_s)
    end

    it 'should use the gem to build the response' do
      Twilio::TwiML::Response.should_receive(:new).and_return(stub(text: nil))

      SmsResponder.respond("anything")
    end
  end

  describe '#self.respond_to_unrecognized_input' do
    it 'should use the gem to build the response' do
      Twilio::TwiML::Response.should_receive(:new).and_return(stub(text: nil))

      SmsResponder.respond_to_unrecognized_input
    end
  end
end