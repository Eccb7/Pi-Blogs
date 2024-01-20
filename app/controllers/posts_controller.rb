class PostsController < ApplicationController
  before_action :set_user

  def index
    @posts = @user.posts
  end

  def show
    @post = @user.posts.find(params[:id])
    @comment = Comment.new # Add this line to initialize a new comment for the form
  end

  def new
    @post = @user.posts.build
  end

  def create
    @post = @user.posts.build(post_params)

    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post created successfully.'
    else
      render :new
    end
  end

  def like
    @post = @user.posts.find(params[:id])
    like = @post.likes.new(user: current_user)

    if like.save
      respond_to do |format|
        format.html { redirect_to user_post_path(@user, @post), notice: 'Liked successfully.' }
        format.js { render :update_likes }
      end
    else
      respond_to do |format|
        format.html { redirect_to user_post_path(@user, @post), alert: 'Unable to like the post.' }
        format.js { render js: 'alert("Unable to like the post.");' }
      end
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
