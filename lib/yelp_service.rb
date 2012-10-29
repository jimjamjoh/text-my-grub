module YelpService
  extend HttpAbstraction

  class << self
    def find_restaurants(cuisine, location, limit=2)
      raw_response = send_get('http://api.yelp.com', '/business_review_search', params(cuisine, location))
      results = []
      raw_response.businesses.each do |restaurant_info|
        results << YelpRestaurantResult.from_service_response(restaurant_info)
        break if results.size == limit
      end
      results
    end

    def params(cuisine, location)
      {ywsid: Sfrubytalkv2::Application.config.yelp_v1_key,
       term: cuisine,
       location: location}
    end
  end
end