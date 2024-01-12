class Comment < ApplicationRecord
  validates :text, presence: true

  attribute :text, :text
  attribute :user_id, :integer
  attribute :post_id, :integer

  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post, class_name: 'Post', foreign_key: 'post_id'

  after_create :increment_post_comments_counter

  private

  def increment_post_comments_counter
    post.increment!(:comments_counter)
  end
end
