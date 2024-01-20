class PostsController < ApplicationController
  before_action :set_user

  def index
    @posts = @user.posts
  end

  def show
    @post = @user.posts.find(params[:id])
  end

  def new
    @post = @user.posts.build
  end

  def create
    @post = @user.posts.build(post_params)

    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post created successfully.'
    else
      render json: { success: false, errors: @post.errors.full_messages }
    end
  end

  def like
    @post = @user.posts.find(params[:id])
    if @post.likes.where(user: current_user).exists?
      redirect_to user_post_path(@user, @post), alert: 'You have already liked this post.'
    else
      @post.likes.create(user: current_user)
      redirect_to user_post_path(@user, @post), notice: 'Liked successfully.'
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
