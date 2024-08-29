class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
   
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    render 'users/show'
    @users = @users.where('name LIKE ?', "%#{params[:keyword]}%").or(
             @users.where('email LIKE ?', "%#{params[:keyword]}%")) if params[:keyword].present?
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_dashboards_path, notice: 'ユーザーを削除しました。'
  end
end
