class PostsController < ApplicationController

  def index
    @posts=Post.all

  end

  def new
    @post=Post.new
    3.times { @post.post_images.build }
  end

  def create
    @post=Post.new(post_params)
    @post.user_id = current_user.id
      if@post.save
        flash[:notice] = "success"
        redirect_to post_path(@post.id)
      else
        flash.now[:alert] = "failed"
        render :new
      end
  end

  def show
    @post=Post.find(params[:id])
    @posts=@post.user

  end

  def edit
    @post=Post.find(params[:id])
  end

  def update
    post=Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path
  end

  def destroy
    post=Post.find(params[:id])
    post.destroy
    redirect_to post_path

  end

  private
  # ストロングパラメータ
  def post_params
    params.require(:post).permit(:title, :body, post_images_attributes: [:image, :title, :body])
  end
end
