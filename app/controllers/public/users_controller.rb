class Public::UsersController < ApplicationController
  def my_page
    @user = current_user
    @posts = @user.posts
  end

  def profile
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to my_page_users_path
  end
  private

  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end
end
