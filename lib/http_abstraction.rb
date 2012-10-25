require_relative 'raise_error'
require_relative 'inject_timestamp'

module HttpAbstraction

  def send_get(host, uri, params)
    Sfrubytalkv2::Application.config.use_faraday ?
      get_with_faraday(host, uri, params) :
      get_with_httparty(host, uri, params)
  end

  def get_with_httparty(host, uri, params)
    HashiefiedParty.new(host + uri, cgi_escape(params)).get
  end

  def get_with_faraday(host, uri, params)
    conn = Faraday.new(url: host) do |faraday|
      faraday.response :raise_error_unless_success
      faraday.response :mashify
      faraday.response :json
      faraday.request :inject_timestamp unless ($VCR_MODE == :playback || $VCR_MODE == :record)
      faraday.adapter  Faraday.default_adapter
    end
    response = conn.get(uri, cgi_escape(params))
    response.body
  end

  def cgi_escape(params)
    escaped_params = {}
    params.each {|k, v| escaped_params.store(k, CGI.escape(v))}
    escaped_params
  end
end