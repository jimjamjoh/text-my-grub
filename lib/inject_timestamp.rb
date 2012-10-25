class InjectTimestamp < Faraday::Middleware
  def call(env)
    env[:url].query += '&timestamp=timestamp'
    @app.call(env)
  end
end

Faraday.register_middleware :request, :inject_timestamp => InjectTimestamp