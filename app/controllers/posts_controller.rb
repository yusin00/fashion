class PostsController < ApplicationController
  def test
  end
  def index
    @posts = Post.all
    
    if params[:search].present?
      posts = Post.posts_search(params[:search])
    elsif params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      posts = @tag.posts.order(created_at: :desc)
    else
      @posts = Post.all.order(created_at: :desc)
    end
    @tag_lists = Tag.all
  end

  def new
    @post = Post.new
    3.times { @post.post_images.build }
  end

  def create
    @post = Post.new(post_params)
    tag_list = params[:post][:tag_name].split(nil).map(&:strip) # カンマ区切りでタグを分割
    @post.image.attach(params[:post][:image])
    @post.user_id = current_user.id
    
    if @post.save  # スペースを追加
      @post.save_posts(tag_list)
      flash[:notice] = "投稿が作成されました"
      redirect_to post_path(@post.id)
    else
      (3 - @post.post_images.size).times { @post.post_images.build }
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
  end  

  def show
    @post = Post.find(params[:id])
    @post_images = @post.post_images
    @post_comment = PostComment.new
    @post_comments = PostComment.includes(:post_image).where('post_images.post_id': @post.id)
    @tags = @post.tags  # ここで関連するタグを取得
  end

  def edit
    @post = Post.find(params[:id])
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
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path  # ここでリダイレクトが完了
    
    # Post_Commentの処理が続いているが、このままでは無効
    # Post_Comment.find(params[:id]).destroy
    # redirect_to post_path(params[:posts_id])  # この行は不要、2回目のリダイレクトが問題
  end

  private
  # ストロングパラメータ
  def post_params
    params.require(:post).permit(:title, :body, post_images_attributes: [:image, :title, :body, :id])
  end
end
