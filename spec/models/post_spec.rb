require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is valid with valid attributes' do
    user = User.create(name: 'Solo Artist', posts_counter: 5)
    user.save
    post = user.posts.create(title: 'Sample Post', comments_counter: 2, likes_counter: 3)
    expect(post).to be_valid
  end

  it 'is not valid without a title' do
    user = User.create(name: 'Maroa Dave', posts_counter: 2)
    post = user.posts.new(title: nil, comments_counter: 1, likes_counter: 0)
    expect(post).to_not be_valid
  end

  it 'is not valid with a long title' do
    user = User.create(name: 'Ojwang Briton', posts_counter: 3)
    post = user.posts.new(title: 'A' * 251, comments_counter: 1, likes_counter: 0)
    expect(post).to_not be_valid
  end

  it 'is not valid with a negative likes_counter' do
    user = User.create(name: 'Brojun Ecc', posts_counter: 1)
    post = user.posts.new(title: 'Sample Post', comments_counter: 1, likes_counter: -1)
    expect(post).not_to be_valid
    expect(post.errors[:likes_counter]).to include('must be greater than or equal to 0')
  end

  it 'is valid with zero likes_counter' do
    user = User.create(name: 'Eve Nicole', posts_counter: 4)
    user.save
    post = user.posts.create(title: 'Sample Post', comments_counter: 3, likes_counter: 0)
    expect(post).to be_valid
  end

  it 'is not valid with a negative comments_counter' do
    user = User.create(name: 'Annie Smith', posts_counter: 1)
    user.save
    post = user.posts.create(title: 'Sample Post', comments_counter: -1, likes_counter: 0)
    expect(post).not_to be_valid
    expect(post.errors[:comments_counter]).to include('must be greater than or equal to 0')
  end

  it 'is valid with zero comments_counter' do
    user = User.create(name: 'Ojwang Briton', posts_counter: 3)
    user.save
    post = user.posts.create(title: 'Yet Another Post', comments_counter: 0, likes_counter: 4)
    expect(post).to be_valid
  end
end