require 'sinatra'
require 'sinatra/json'
require 'dotenv/load'

require_relative './db/connect'
require_relative './controllers/likes_controller'
require_relative './middleware/auth_middleware'  # << NUEVO

set :port, ENV['PORT'] || 3020
set :bind, '0.0.0.0'

use AuthMiddleware  # << AÑADIR middleware

before do
  content_type :json
end

get '/' do
  json message: 'Like Service is running!'
end

# Accede al usuario autenticado con env['current_user']
get '/api/v1/likes/:type/:id' do |type, id|
  LikesController.get_likes(type, id)
end

post '/api/v1/likes' do
  request.body.rewind
  data = JSON.parse(request.body.read)
  data['user_id'] = request.env['current_user']['id']  # ✅ Sobrescribir con el del token
  request.env['rack.input'] = StringIO.new(data.to_json)  # Reinyecta el body modificado
end
