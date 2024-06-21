class ApplicationController < ActionController::Base
  before_action :set_notifications_count

  private

  def set_notifications_count
    if user_signed_in?
      @unread_notifications_count = current_user.notifications.unread.count
    else
      @unread_notifications_count = 0
    end
  end
end