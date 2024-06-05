class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      flash.now[:alert] = "保存に失敗しました"
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end

private
  
  def post_params
    params.require(:post).permit(:title, :body, :post_image)
  end
