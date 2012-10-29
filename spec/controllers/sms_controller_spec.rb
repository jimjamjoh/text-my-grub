require 'spec_helper'

describe SmsController do
  let(:cuisine) {'my favourite food'}
  let(:five_digit_zip_code) {'75206'}
  let(:params) {{Body: "#{cuisine} #{five_digit_zip_code}"}}
  let(:two_restaurants) {[stub(YelpRestaurantResult), stub(YelpRestaurantResult)]}
  let(:an_sms_response) {""}
  describe '#inbound' do
    before :each do
      YelpService.stub(:find_restaurants).and_return(two_restaurants)
      SmsResponder.stub(:respond).and_return(an_sms_response)
    end

    it 'should query the Yelp service' do
      YelpService.should_receive(:find_restaurants).with(cuisine, five_digit_zip_code)

      post(:inbound, params)
    end

    it 'should pass the results to the SmsResponder' do
      SmsResponder.should_receive(:respond).with(two_restaurants).and_return(an_sms_response)

      post(:inbound, params)
    end
  end
end