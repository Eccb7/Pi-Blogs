require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'can be created' do
    user = User.create(name: 'Test User')
    post = Post.create(title: 'Test Post')

    like = Like.new(user: user, post: post, text: 'This is a test like.')

    expect(like).to be_valid
  end

  it 'increments likes_counter when a like is added' do
    user = User.create(name: 'John Doe', posts_counter: 1)
    post = user.posts.create(title: 'Increments Test', comments_counter: 0, likes_counter: 0)

    expect do
      post.increment!(:likes_counter)
    end.to change { post.likes_counter }.by(1)
  end
end
