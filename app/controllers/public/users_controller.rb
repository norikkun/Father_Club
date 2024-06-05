class Public::UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
  end
# ユーザーの投稿一覧
  def posts
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def show
    @user = current_user
  end

  def update
  end

  def follower
  end

  def followed
  end

  def confirm
  end

  def withdraw
  end
end
