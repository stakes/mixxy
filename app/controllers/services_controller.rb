class ServicesController < ApplicationController
  def index
  end
  
  def create
    omniauth = request.env["omniauth.auth"]      
    render :text => omniauth.to_yaml
  end
  
  def destroy
  end
end