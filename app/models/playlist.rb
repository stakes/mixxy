class Playlist
  include Mongoid::Document
  field :name, :type => String
  field :url, :type => String
  field :source, :type => String
  field :playlist_id, :type => String
  field :owner_id, :type => String
  field :image_url, :type => String
  has_and_belongs_to_many :users
  
  def self.get_sc_followings_playlists(user_id)
    client = Soundcloud.new(:access_token => User.find(user_id).get_auth('soundcloud').token)
    playlist_array = []
    followings = client.get("/me/followings")
    followings.each do |f|
      if f.playlist_count > 0
        playlists = client.get("/users/#{f.id}/playlists", :limit => 2)
        playlists.each do |r|
          obj = {}
          obj["username"] = f.username
          obj['name'] = r.title
          obj['image_url'] = r.artwork_url
          obj['image_url'] = r.tracks[0].artwork_url if (!r.tracks[0].blank? and obj['image_url'].nil?)
          obj['image_url'] = r.user.avatar_url if obj['image_url'].nil?
          obj['image_url'] = '/assets/default-soundcloud.png' if obj['image_url'].include? 'default_avatar_large.png'
          obj['playlist_url'] = r.uri
          obj['source']= 'soundcloud'
          playlist_array << obj
        end
      end
    end
    
    return playlist_array
  end
  
  def self.get_rdio_playlists(rdio_client)
    
    
    playlists = rdio_client.getPlaylists(:user => "#{rdio_client.currentUser[:key]}")

    playlists = playlists.collab + playlists.owned + playlists.subscribed
    playlist_array = []
    playlists.each do |r|
      obj = {}
      obj['username'] = rdio_client.currentUser[:firstName]+' '+rdio_client.currentUser[:lastName]
      obj['name'] = r.name
      obj['image_url'] = r.icon
      obj['playlist_url'] = r.embedUrl
      obj['source'] = 'rdio'
      playlist_array << obj
    end

    
    return playlist_array
  end
  
  
end
