class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:posts, :show]
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def edit
    @user = User.find(params[:id])
  end


  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "プロフィールを更新しました"
      redirect_to user_path(@user)
    else
      flash[:alert] = @user.errors.full_messages.join(", ")
      redirect_to request.referer
    end
  end

  def follower
  end

  def followed
  end

  def confirm
    @user = current_user
  end

  # 顧客の退会処理(ステータスの更新)
  def withdraw
    @user = User.find(current_user.id)
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :introduction, :user_image)
  end
  
  def is_matching_login_user
    begin
      user = User.find(params[:id])
      unless user.id == current_user.id
        redirect_to user_path(current_user)
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to user_path(current_user)
    end
  end
end