module UrlShorteningService
  extend HttpAbstraction

  class << self
    def shorten_url(longish_url)
      raw_response = send_get('http://api.bit.ly', '/v3/shorten', params(longish_url))
      raw_response.data.url
    end

    private

    def params(url)
      {format: 'json',
       login: Sfrubytalkv2::Application.config.bitly_login,
       apiKey: Sfrubytalkv2::Application.config.bitly_key,
       longUrl: url}
    end
  end
end