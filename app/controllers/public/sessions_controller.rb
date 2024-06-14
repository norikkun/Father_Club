# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]
  
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  
 protected

  def after_sign_out_path_for(resource)
    root_path
  end
  
 private
 # アクティブであるかを判断するメソッド
  def user_state
    # 【処理内容1】 入力されたemailからアカウントを1件取得
    user = User.find_by(email: params[:user][:email])
    # 【処理内容2】 アカウントを取得できなかった場合、このメソッドを終了する
    return if user.nil?
    # 【処理内容3】 取得したアカウントのパスワードと入力されたパスワードが一致していない場合、このメソッドを終了する
    return unless user.valid_password?(params[:user][:password])
  
    # 【処理内容4】 アクティブでない会員に対する処理
    if !user.is_active
    # アカウントが有効化されていない場合の処理を記述
    # 例えば、エラーメッセージを表示したり、特定のページにリダイレクトさせたりすることができます
    flash[:notice] = "アカウントが有効化されていません。もう一度新規登録を行ってください"
    redirect_to new_user_registration_path and return
    end
  end
end
