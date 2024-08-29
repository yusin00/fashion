class Admin::DashboardsController < ApplicationController
   layout 'admin'
   before_action :authenticate_admin!
    def index
      @users = User.all
      @users = @users.where('name LIKE ?', "%#{params[:keyword]}%").or(
               @users.where('email LIKE ?', "%#{params[:keyword]}%")) if params[:keyword].present?
    end
end
