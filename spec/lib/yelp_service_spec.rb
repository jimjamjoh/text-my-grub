require "spec_helper"

describe YelpService do
  use_vcr_cassette 'find_restaurants'

  let(:cuisine){'thai'}
  let(:location){'75201'}

  it "should return two listings" do
    restaurants = YelpService.find_restaurants cuisine, location
    restaurants.size.should == 2
  end
end