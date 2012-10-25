class InjectTimestamp < Faraday::Middleware
  def call(env)
    env[:url].query += "&timestamp=#{CGI.escape(Time.now.to_s)}"
    @app.call(env)
  end
end

Faraday.register_middleware :request, :inject_timestamp => InjectTimestamp