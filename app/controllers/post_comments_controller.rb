class PostCommentsController < ApplicationController
   def create
    @post_image = PostImage.find(params[:post_image_id])
    @post_comment = current_user.post_comments.build(post_comment_params)
    if @post_comment.save
      flash[:notice] = "success"
      redirect_to post_image_path(@post_image)
    else
      @post_comments = @post_image.post_comments
      flash.now[:alert] = "failed"
      render 'post_images/show'
    end
  end

  def index
    @post = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end

    def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_path(params[:posts_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment).merge(post_image_id: params[:post_image_id])
  end
end
