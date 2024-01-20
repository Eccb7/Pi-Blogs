class CommentsController < ApplicationController
  before_action :set_user_and_post

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user # assuming you have a current_user method

    if @comment.save
      # Update the comments list and comments_counter
      @comments = @post.comments.order(created_at: :desc)
      @post.update(comments_counter: @comments.count)

      # Redirect or render as needed
      redirect_to user_post_path(@user, @post), notice: 'Comment added successfully'
    else
      # Handle validation errors
      render 'posts/show'
    end
  end

  private

  def set_user_and_post
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
