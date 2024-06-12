class Public::SearchesController < ApplicationController
  
  def search
    @range = params[:range]

    if @range == "ユーザー"
      @users = User.looks(params[:search], params[:word])
    else
      @posts = Post.looks(params[:search], params[:word]).order(created_at: :desc)
    end
  end
end
