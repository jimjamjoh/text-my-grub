class RaiseError < Faraday::Middleware
  def call(env)
    call = @app.call env
    call.on_complete do |service_response|
      raise RuntimeError.new unless (200..299).include?(service_response[:status])
    end
  end

end

Faraday.register_middleware :response, :raise_error_unless_success => RaiseError