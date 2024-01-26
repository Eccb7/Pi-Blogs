class PostsController < ApplicationController
  before_action :set_user, only: %i[index show new create like]

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
      # Log validation errors to help diagnose the issue
      Rails.logger.error(@post.errors.full_messages.to_sentence)
      render :new
    end
  end

  def like
    @post = @user.posts.find(params[:id])
    if @post.likes.where(user: current_user).exists?
      redirect_to user_post_path(@user, @post), alert: 'You have already liked this post.'
    else
      @post.likes.create(user: current_user)
      @post.increment!(:likes_counter)
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
