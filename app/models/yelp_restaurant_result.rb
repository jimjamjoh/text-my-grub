class YelpRestaurantResult < Hashie::Dash
  property :name
  property :address
  property :phone
  property :url

  def to_s
    stringification = "#{self.name}\n#{self.address}"
    stringification += "\n#{self.phone}" unless YelpRestaurantResult.empty?(self.phone)
    stringification += "\n\n#{self.url}" unless YelpRestaurantResult.empty?(self.url)
    stringification
  end

  def self.from_service_response raw_yelp_info
    name = raw_yelp_info.name
    address = raw_yelp_info.address1
    address += "\n#{raw_yelp_info.address2}" unless empty?(raw_yelp_info.address2)
    address += "\n#{raw_yelp_info.city} #{raw_yelp_info.state}"
    phone = raw_yelp_info.phone unless empty?(raw_yelp_info.phone)
    url = raw_yelp_info.url
    YelpRestaurantResult.new(name: name, address: address, phone: phone, url: url)
  end

  def self.empty?(value)
    return value.nil? || value.strip.size == 0
  end
end