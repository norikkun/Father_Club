class Public::SessionsController < Devise::SessionsController
  before_action :user_status, only: [:create]

  def create
    super
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: "ゲストユーザーとしてログインしました。"
  end

  protected

  def after_sign_out_path_for(resource)
    root_path
  end

  private

  # アクティブであるかを判断するメソッド
  def user_status
    user = User.find_by(email: params[:user][:email])
    return if user.nil?
    return unless user.valid_password?(params[:user][:password])

    unless user.is_active?
      sign_out(user) if user_signed_in?
      redirect_to new_user_session_path, alert: "退会済みです。別のメールアドレスをお使いください。"
    end
  end
end