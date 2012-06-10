class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @likes = []
    @user.likes.each {|l| @likes << Playlist.find(l)}
    @playlists = @user.playlists
    
    
  end
  
  def me
    
    if current_user.blank?
      redirect_to '/'
    else
      @user = current_user
      @likes = []
      @user.likes.each {|l| @likes << Playlist.find(l)}
      @playlists = @user.playlists
      render :show
    end
    
  end
  
  def add_service
    current_user.add_service_with_omniauth(params[:provider])
  end
  
  def get_sc_followings_playlists
    data = Playlist.get_sc_followings_playlists(current_user.id.to_s)
    render :json => data
  end
end
