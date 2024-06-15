class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  
  def new
    @post = Post.new
  end
  
  def index
    @posts = Post.includes(:user).order(created_at: :desc)
  end

  def show
    @post = Post.includes(:user).find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿に成功しました"
      redirect_to post_path(@post)
    else
      flash[:alert] = @post.errors.full_messages.join(", ")
      redirect_to request.referer
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿を更新しました"
      redirect_to post_path(@post)
    else
      flash[:alert] = @post.errors.full_messages.join(", ")
      redirect_to request.referer
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to posts_path
  end

private
  
  def post_params
    params.require(:post).permit(:user_id, :title, :body, :post_image)
  end
  
  # ログイン時の他のユーザーのアクセス制限
  def is_matching_login_user
    begin
      post = Post.find(params[:id])
      unless post.user_id == current_user.id
        redirect_to posts_path
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to posts_path
    end
  end
end