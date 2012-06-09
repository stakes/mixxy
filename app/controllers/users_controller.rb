class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  def add_service
    current_user.add_service_with_omniauth(params[:provider])
  end

end
