class YelpService
  include HttpAbstraction

  API_HOST = 'http://api.yelp.com'

  def self.find_restaurants(cuisine, location, limit=2)
    query_params = {ywsid: Sfrubytalkv2::Application.config.yelp_v1_key,
                    cuisine: CGI.escape(cuisine),
                    location: CGI.escape(location)}
    raw_response = HttpAbstraction.send_get(API_HOST, '/business_review_search', query_params)
    results = []
    raw_response.businesses.each do |restaurant_info|
      results << YelpRestaurantResult.new(restaurant_info)
      break if results.size == limit
    end
    results
  end
end