class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.all
  end

  def show
    if @user.nil?
      redirect_to root_path, alert: 'User not found'
    else
      @posts = @user.posts.any? ? @user.posts.page(params[:page]) : []
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end
end
