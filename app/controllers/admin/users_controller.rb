class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def edit
    @user = User.find(params[:id])
  end

  def index
    @users = User.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:notice] = "プロフィールを変更しました"
    redirect_to admin_user_path(@user)
  end
  
  private
  
  def user_params
  params.require(:user).permit(:is_active)
  end
end
