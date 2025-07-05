class Like
  attr_reader :user_id, :target_id, :target_type

  def initialize(params)
    @user_id = params['user_id']
    @target_id = params['target_id']
    @target_type = params['target_type']
    @liked_at = Time.now
  end

  def to_document
    {
      user_id: @user_id,
      target_id: @target_id,
      target_type: @target_type,
      liked_at: @liked_at
    }
  end
end
