module HttpAbstraction

  def self.send_get(host, uri, params)
    Sfrubytalkv2::Application.config.use_faraday ?
      get_with_faraday(host, uri, params) :
      get_with_httparty(host, uri, params)
  end

  def self.get_with_faraday(host, uri, params)
    conn = Faraday.new(url: host) do |faraday|
      faraday.response :mashify
      faraday.response :json
      faraday.adapter  Faraday.default_adapter
    end
    response = conn.get(uri, cgi_escape(params))
    response.body
  end

  def self.get_with_httparty(host, uri, params)
    response = HTTParty.get(host + uri, query: cgi_escape(params))
    Hashie::Mash.new(JSON.parse(response))
  end

  def self.cgi_escape(params)
    escaped_params = {}
    params.each {|k, v| escaped_params.store(k, CGI.escape(v))}
    escaped_params
  end
end