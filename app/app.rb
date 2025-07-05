require 'sinatra'
require 'sinatra/json'
require 'dotenv/load'
require_relative './db/connect'
require_relative './controllers/likes_controller'

set :port, ENV['PORT'] || 3020
set :bind, '0.0.0.0'

before do
  content_type :json
end

get '/' do
  json message: 'Like Service is running!'
end

# Rutas del servicio
get '/api/v1/likes/:type/:id', &LikesController.method(:get_likes)
post '/api/v1/likes', &LikesController.method(:create_like)
delete '/api/v1/likes/:type/:id/:user_id', &LikesController.method(:delete_like)
