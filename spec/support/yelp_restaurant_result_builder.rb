class YelpRestaurantResultBuilder
  def initialize
    @attrs = Hashie::Mash.new(name: "", address1: "", city: "", state: "", url: "")
  end

  def with_url url
    @attrs.url = url
    self
  end

  def build
    YelpRestaurantResult.from_service_response @attrs
  end
end