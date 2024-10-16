class PostImagesController < ApplicationController
  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end
  
  def destroy
    Post_Comment.find(params[:id]).destroy
    redirect_to post_path(params[:posts_id])
  end
end