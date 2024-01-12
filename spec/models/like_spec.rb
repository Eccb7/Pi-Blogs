require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'can be created' do
    user = User.create(name: 'Test User')
    post = Post.create(title: 'Test Post')

    like = Like.new(user: user, post: post, text: 'This is a test like.')

    expect(like).to be_valid
  end
end
