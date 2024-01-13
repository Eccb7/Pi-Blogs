# spec/models/comment_spec.rb

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'can be created' do
    user = User.create(name: 'Test User')
    post = Post.create(title: 'Test Post')

    comment = Comment.new(user: user, post: post, text: 'This is a test comment.')

    expect(comment).to be_valid
  end

  it 'increments comments_counter when a comment is added' do
    user = User.create(name: 'Jane Doe', posts_counter: 1)
    post = user.posts.create(title: 'Increments Test', comments_counter: 0, likes_counter: 0)

    expect do
      post.increment!(:comments_counter)
    end.to change { post.comments_counter }.by(1)
  end
end
