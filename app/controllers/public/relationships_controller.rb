class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  def create
    user = User.find(params[:user_id])
    if current_user.follow(user)
      redirect_to request.referer, notice: "フォローしました"
    else
      redirect_to request.referer, alert: "フォローできませんでした"
    end
  end
  
  def destroy
    user = User.find(params[:user_id])
    if current_user.unfollow(user)
      redirect_to request.referer, notice: "フォローを解除しました"
    else
      redirect_to request.referer, alert: "フォローを解除できませんでした"
    end
  end
  
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
    # 以下はビューでの表示例
    # render 'followings'
  end
  
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
    # 以下はビューでの表示例
    # render 'followers'
  end
end
