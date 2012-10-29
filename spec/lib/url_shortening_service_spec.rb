require "spec_helper"

describe UrlShorteningService do
  use_vcr_cassette('shorten_urls')

  let(:long_url){"http://someobscenelylongurlthatabsolutelyneedsshortening.com"}

  it "should shorten my urls" do
    shorter_url = UrlShorteningService.shorten_url(long_url)
    shorter_url.size.should < long_url.size
  end
end