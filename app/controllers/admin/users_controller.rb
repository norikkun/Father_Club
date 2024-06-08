class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def edit
  end

  def index
  end
  
  # 各ユーザーの投稿一覧
  def posts
  end

  def show
  end

  def update
  end
end
