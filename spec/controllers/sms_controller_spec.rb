require 'spec_helper'

describe SmsController do
  let(:cuisine) {'my favourite food'}
  let(:five_digit_zip_code) {'75206'}
  let(:params) {{Body: "#{cuisine} #{five_digit_zip_code}"}}
  let(:first_restaurant_url) {'http://some.url.com'}
  let(:first_restaurant) {YelpRestaurantResultBuilder.new.with_url(first_restaurant_url).build}
  let(:second_restaurant_url) {'http://another.url.com'}
  let(:second_restaurant) {YelpRestaurantResultBuilder.new.with_url(second_restaurant_url).build}
  let(:two_restaurants) {[first_restaurant, second_restaurant]}
  let(:an_sms_response) {"some informative response"}

  describe '#inbound' do
    before :each do
      YelpService.stub(:find_restaurants).and_return(two_restaurants)
      UrlShorteningService.stub(:shorten_url)
      SmsResponder.stub(:respond).and_return(an_sms_response)
    end

    it 'should query the Yelp service' do
      YelpService.should_receive(:find_restaurants).with(cuisine, five_digit_zip_code)

      post(:inbound, params)
    end

    it 'should query the URL-shortening service for each restaurant returned' do
      first_shortened_url = "http//1st.url"
      second_shortened_url = "http//2nd.url"
      UrlShorteningService.should_receive(:shorten_url).with(first_restaurant_url).and_return(first_shortened_url)
      UrlShorteningService.should_receive(:shorten_url).with(second_restaurant_url).and_return(second_shortened_url)

      post(:inbound, params)

      first_restaurant[:url].should == first_shortened_url
      second_restaurant[:url].should == second_shortened_url
    end

    it 'should pass the results to the SmsResponder and render its response as xml' do
      SmsResponder.should_receive(:respond).with(two_restaurants).and_return(an_sms_response)

      post(:inbound, params)

      response.body.should == an_sms_response
      response.content_type.should == :xml
    end
  end
end