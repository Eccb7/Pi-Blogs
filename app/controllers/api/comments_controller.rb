module Api
  class CommentsController < ApplicationController
    before_action :authenticate_user!, only: [:create, :destroy]
    before_action :set_user_and_post

    def index
      @comments = @post.comments
      render json: @comments
    end

    def create
      @comment = @post.comments.new(comment_params)
      @comment.user = current_user

      if @comment.save
        render json: @comment, status: :created
      else
        render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def set_user_and_post
      @user = User.find(params[:user_id])
      @post = @user.posts.find(params[:post_id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Post not found' }, status: :not_found
    end

    def comment_params
      params.require(:comment).permit(:text)
    end
  end
end
