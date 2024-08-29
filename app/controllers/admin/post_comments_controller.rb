class Admin::PostCommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @post_comments = PostComment.all
    @post_comments = @post_comments.where('comment LIKE ?', "%#{params[:keyword]}%") if params[:keyword].present?

  end

  def destroy
    @post_comment = PostComment.find_by_id(params[:id])
    @post_comment.destroy if @post_comment
    flash[:success] = "コメントを削除しました。"
    redirect_to admin_post_comments_path
  end
end
