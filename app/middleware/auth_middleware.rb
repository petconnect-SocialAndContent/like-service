# middleware/auth_middleware.rb
require 'jwt'

class AuthMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)
    auth_header = req.get_header('HTTP_AUTHORIZATION')
    token = auth_header&.split(' ')&.last

    if token.nil?
      return unauthorized_response('Token not provided')
    end

    begin
      decoded = JWT.decode(token, ENV['JWT_SECRET'] || 'supersecreto123diegopetconnect456', true, { algorithm: 'HS256' })
      env['current_user'] = decoded[0] # Agrega el payload al entorno
      @app.call(env)
    rescue JWT::DecodeError => e
      unauthorized_response("Invalid token: #{e.message}")
    end
  end

  private

  def unauthorized_response(message)
    [
      401,
      { 'Content-Type' => 'application/json' },
      [{ error: message }.to_json]
    ]
  end
end
