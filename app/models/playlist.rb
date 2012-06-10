class Playlist
  include Mongoid::Document
  field :name, :type => String
  field :url, :type => String
  field :source, :type => String
  field :playlist_id, :type => String
  field :image_url, :type => String
  has_and_belongs_to_many :users
  
  def get_sc_followings_playlists(user)
    client = Soundcloud.new(:access_token => user.service_credentials('soundcloud').token)
    
  end
end
