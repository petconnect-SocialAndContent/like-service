require_relative '../models/likeModels'

module LikesController
  def self.get_likes(type, id)
    likes = LIKES_COLLECTION.find({ target_type: type, target_id: id }).to_a
    [200, likes.to_json]
  end

  def self.create_like
    data = JSON.parse(request.body.read)
    existing = LIKES_COLLECTION.find({
      user_id: data['user_id'],
      target_id: data['target_id'],
      target_type: data['target_type']
    }).first

    return [409, { error: 'Like already exists' }.to_json] if existing

    like = Like.new(data)
    LIKES_COLLECTION.insert_one(like.to_document)
    [201, { message: 'Like created' }.to_json]
  end

  def self.delete_like(type, id, user_id)
    result = LIKES_COLLECTION.delete_one({
      target_type: type,
      target_id: id,
      user_id: user_id
    })

    if result.deleted_count > 0
      [200, { message: 'Like deleted' }.to_json]
    else
      [404, { error: 'Like not found' }.to_json]
    end
  end
end
