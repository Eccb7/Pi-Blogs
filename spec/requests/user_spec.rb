require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'renders the index template' do
      user = create(:user)

      get users_path

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end

    it 'assigns all posts to @posts' do
      user = create(:user)
      post = create(:post, author: user)

      get user_posts_path(user)

      expect(assigns(:posts)).to eq([post])
    end
  end

  describe 'GET /show' do
    it 'renders the show template' do
      user = create(:user)

      get user_path(user)

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
    end

    it 'assigns the requested user to @user' do
      user = create(:user)

      get user_path(user)

      expect(assigns(:user)).to eq(user)
    end
  end
end
