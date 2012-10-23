require "spec_helper"

describe YelpService do
  use_vcr_cassette 'find_restaurants'
  it "should return twenty listings" do
    response = YelpService.find_restaurants 'thai', '75201'
    response.businesses.size.should == 20
  end
end