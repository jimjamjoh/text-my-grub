class RaiseError < Faraday::Middleware
  def call(env)
    response = @app.call env
    response.on_complete do |env|
      raise RuntimeError.new unless (200..299).include?(env[:status])
    end
  end

end

Faraday.register_middleware :response, :raise_error_unless_success => RaiseError