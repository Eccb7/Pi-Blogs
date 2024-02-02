class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  load_and_authorize_resource
  before_action :set_user, only: %i[index show new create like]

  def index
    @posts = @user.posts.includes(:comments)
  end

  def show
    authorize! :read, @post
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
      Rails.logger.error(@post.errors.full_messages.to_sentence)
      render :new
    end
  end

  def like
    authorize! :like, @post
    @post = @user.posts.find(params[:id])
    like = @post.likes.new(user: current_user)

    if like.save
      respond_to do |format|
        format.html { redirect_to user_post_path(@user, @post), notice: 'Liked successfully.' }
        format.js { render :update_likes }
      end
    else
      @post.likes.create(user: current_user)
      @post.increment!(:likes_counter)
      redirect_to user_post_path(@user, @post), notice: 'Liked successfully.'
    end
  end

  def update
    @post.update(post_params)
  end

  

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
