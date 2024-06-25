class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to post_path(params[:post_id])
  end
end
