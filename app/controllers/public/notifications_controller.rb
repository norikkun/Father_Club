class Public::NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.order(created_at: :desc).page(params[:page]).per(10)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end

  def destroy_all
    current_user.notifications.destroy_all
    redirect_to notifications_path, notice: "全ての通知が削除されました。"
  end
end
