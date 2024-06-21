class Public::SearchesController < ApplicationController

  def search
    @range = params[:range]
    if @range == "user"
      @users = User.looks(params[:word]).order(created_at: :desc).page(params[:page]).per(10)
    else
      @posts = Post.looks(params[:word]).order(created_at: :desc)
    end
  end
end
