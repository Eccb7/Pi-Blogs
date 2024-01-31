require 'rails_helper'

RSpec.describe Post, type: :model do
  self.use_transactional_tests = true

  it 'is valid with valid attributes' do
    user = create(:user, name: 'Solo Artist', posts_counter: 5)
    post = user.posts.create(title: 'Sample Post', text: 'Some text here', comments_counter: 3, likes_counter: 0)


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

  describe '#increment_user_posts_counter' do
    it 'increments the author\'s posts_counter by 1' do
      author = User.create(name: 'Test Author', posts_counter: 2)
      author.posts.create(title: 'Test Post', comments_counter: 1, likes_counter: 0)

      # Reload the author instance to get the updated posts_counter value
      author.reload

      # Expect the author's posts_counter to be incremented by 1
      expect(author.posts_counter).to eq(3)
    end
  end

  describe '#recent_comments' do
    before :all do
      @author = User.create(name: 'John Doe', posts_counter: 1)
      @post = Post.create(author: @author, title: 'Kathy', text: 'Text here....', comments_counter: 0, likes_counter: 0)

      # Creating 8 comments associated with the post
      8.times { |comment_i| Comment.create(user: @author, text: (comment_i + 1).to_s) }
    end

    it 'returns five most recent comments' do
      expected_comments = @post.comments.order(created_at: :desc).limit(5)

      # Ensure the method returns the five most recent comments
      expect(@post.recent_comments).to eq(expected_comments)
    end
  end
end
