require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(name: 'John Doe', posts_counter: 5)
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user = User.new(name: nil, posts_counter: 5)
    expect(user).to_not be_valid
  end

  it 'is not valid with a negative posts_counter' do
    user = User.new(name: 'Jane Smith', posts_counter: -1)
    expect(user).to_not be_valid
  end

  it 'is valid with zero posts_counter' do
    user = User.new(name: 'Alice Johnson', posts_counter: 0)
    expect(user).to be_valid
  end

  it 'returns the most recent posts' do
    user = User.create(name: 'John Doe', posts_counter: 5)
    older_post = user.posts.create(title: 'Old Post', comments_counter: 2, likes_counter: 3, created_at: 3.days.ago)
    newer_post = user.posts.create(title: 'New Post', comments_counter: 2, likes_counter: 3, created_at: 1.day.ago)

    recent_posts = user.recent_posts

    expect(recent_posts).to eq([newer_post, older_post])
  end
end
