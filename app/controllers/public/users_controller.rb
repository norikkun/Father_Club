class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:posts, :show]
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]

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

  def favorites
    @user = User.find(params[:user_id])
    favorite_ids = Favorite.where(user_id: @user.id).order(created_at: :desc).pluck(:post_id)
    @favorite_posts = Post.find(favorite_ids).sort_by { |post| favorite_ids.index(post.id) }
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

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user), notice: "ゲストユーザーは編集画面へ遷移できません。"
    end
  end

  # ログイン時の他のユーザーのアクセス制限
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      flash[:notice] = "他のユーザーの編集は出来ません"
      redirect_to user_path(current_user)
    end
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "他のユーザーの編集は出来ません"
    redirect_to user_path(current_user)
  end
end
