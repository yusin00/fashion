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
      (3 - @post.post_images.size).times { @post.post_images.build }
      flash.now[:alert] = "failed"
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_images = @post.post_images
    @post_comment = PostComment.new
    @post_comments = PostComment.includes(:post_image).where('post_images.post_id': @post.id)
  end

  def edit
    @post=Post.find(params[:id])
    (3 - @post.post_images.size).times { @post.post_images.build }
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "success"
      redirect_to post_path(@post.id)
    else
      @post.post_images.reload
      flash.now[:alert] = "failed"
      render :edit
    end
  end

  def destroy
    post=Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  private
  # ストロングパラメータ
  def post_params
    params.require(:post).permit(:title, :body, post_images_attributes: [:image, :title, :body, :id])
  end
end
