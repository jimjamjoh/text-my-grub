class HashiefiedParty
  include HTTParty

  def initialize(url, params)
    @url = url
    params.merge!(timestamp: 'timestamp') unless ($VCR_MODE == :playback || $VCR_MODE == :record)
    @params = params
  end

  def get
    response = self.class.get(@url, query: @params)
    Hashie::Mash.new(JSON.parse(response))
  end
end