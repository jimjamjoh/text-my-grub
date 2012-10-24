class YelpRestaurantResult
  attr_reader :name, :address, :phone, :url

  def initialize raw_yelp_info
    parse_raw_info raw_yelp_info
  end

  def to_s
    stringification = "#{@name}\n#{@address}"
    stringification += "\n#{@phone}" unless empty?(@phone)
    stringification
  end

  private

  def parse_raw_info raw_yelp_info
    @name = raw_yelp_info.name
    @address = raw_yelp_info.address1
    @address += "\n#{raw_yelp_info.address2}" unless empty?(raw_yelp_info.address2)
    @address += "\n#{raw_yelp_info.city} #{raw_yelp_info.state}"
    @phone = raw_yelp_info.phone unless empty?(raw_yelp_info.phone)
  end

  def empty?(value)
    return value.nil? || value.strip.size == 0
  end
end