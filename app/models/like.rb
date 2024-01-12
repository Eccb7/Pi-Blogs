class Like < ApplicationRecord
  validates :text, presence: true

  attribute :text, :text
  attribute :user_id, :integer
  attribute :post_id, :integer

  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post, class_name: 'Post', foreign_key: 'post_id'

  private

  def increment_post_likes_counter
    post.increment!(:likes_counter)
  end
end
