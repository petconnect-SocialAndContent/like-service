require 'mongo'

Mongo::Logger.logger.level = ::Logger::INFO

DB = Mongo::Client.new(ENV['MONGODB_URI'], database: 'likedb')
LIKES_COLLECTION = DB[:likes]
