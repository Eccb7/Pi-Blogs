class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_post_and_comment, only: %i[new create destroy]

  def new
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      update_comments_list_and_counter
      redirect_to user_post_path(@user, @post), notice: 'Comment added successfully.'
    else
      render 'new'
    end
  end

  def destroy
    authorize! :destroy, @comment

    if @comment.destroy
      update_comments_list_and_counter
      redirect_to user_post_path(@user, @post), notice: 'Comment was successfully destroyed.'
    else
      redirect_to user_post_path(@user, @post), alert: 'Error destroying comment.'
    end
  end

  private

  def set_user_post_and_comment
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id]) if params[:id]
  end

  def comment_params
    params.require(:comment).permit(:text)
  end

  def update_comments_list_and_counter
    @comments = @post.comments.includes(:user).order(created_at: :desc)
    @post.update(comments_counter: @comments.count)
  end
end
