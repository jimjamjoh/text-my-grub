require "spec_helper"

describe YelpService do
  use_vcr_cassette 'find_restaurants'
  it "should ask the service for food options" do
    response = YelpService.find_restaurants 'thai', '75201'
  end
end