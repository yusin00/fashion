class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def mypage
    #@users=User.all
    #@users = @users.where('name LIKE ?', "%#{params[:keyword]}%").or(
    #         @users.where('email LIKE ?', "%#{params[:keyword]}%")) if params[:keyword].present?
    @user = current_user
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
     @user = User.find(params[:id])
  end

  def update
     @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def destroy
    @user.destroy
    flash[:notice] = "退会しました。"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def correct_user
    @user = User.find_by_id(params[:id])
    redirect_to new_user_registration_path if @user != current_user
  end
end
