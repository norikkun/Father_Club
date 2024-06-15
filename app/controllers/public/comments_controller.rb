class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to post_path(post)
  end

  def destroy
    comment = Comment.find(params[:id])

    if comment.user_id == current_user.id
      comment.destroy
      flash[:notice] = "コメントを削除しました"
      redirect_to post_path(params[:post_id])
    else
      redirect_to post_path(params[:post_id])
    end
  end

  private

  def comment_params
     params.require(:comment).permit(:comment)
  end

end
