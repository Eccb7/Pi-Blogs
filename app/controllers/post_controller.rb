class PostController < ApplicationController
  def index
    @user = User.find(params[:id])
    @user.posts
  end

  def show
    @post = Post.find(params[:id])
  end
end
