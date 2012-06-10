class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  before_filter :get_rdio_client

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
  
  def get_rdio_playlists
    data = Playlist.get_rdio_playlists(@rdio_client)
    render :json => data
  end
  
  def get_youtube_playlists
    data = current_user.youtube_playlists
    render :json => data
  end
  
  protected
  def get_rdio_client
    if current_user.has_service('rdio')
      @rdio_client ||= RdioApi.new(:consumer_key => ENV["RDIO_APP_KEY"], :consumer_secret => ENV["RDIO_APP_SECRET"], :access_token => session[:access_token])
    end
  end
end
