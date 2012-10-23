class YelpService
  # To change this template use File | Settings | File Templates.

  def self.find_restaurants(cuisine, location, limit=2)
    response = HTTParty.get('http://api.yelp.com/business_review_search',
        query: {ywsid: Sfrubytalkv2::Application.config.yelp_v1_key,
                cuisine: CGI.escape(cuisine),
                location: CGI.escape(location)})
    puts response
    response
  end

  def self.buffalo
    true
  end
end