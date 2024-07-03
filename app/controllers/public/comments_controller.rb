class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = post.id
    unless @comment.save
     flash[:comment] = "コメントを入力してください"
     render 'error'
    end
    @comments = post.comments.order(created_at: :desc).page(params[:page]).per(10)
  end

  def destroy
    post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.user_id == current_user.id
    @comment.destroy
    @comments = post.comments.order(created_at: :desc).page(params[:page]).per(10)
  end

  private
    def comment_params
      params.require(:comment).permit(:comment)
    end
end
