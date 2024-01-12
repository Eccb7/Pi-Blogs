require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'can be created' do
    user = User.create(name: 'Test User')
    post = Post.create(title: 'Test Post')

    comment = Comment.new(user: user, post: post, text: 'This is a test comment.')

    expect(comment).to be_valid
  end
end
