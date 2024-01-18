class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      # Handle the case where the user is not found, e.g., redirect to an error page
      redirect_to root_path, alert: 'User not found'
    else
      @posts = @user.posts
    end
  end
end
