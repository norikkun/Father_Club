class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to posts_path
  end
  
end
