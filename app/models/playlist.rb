class Playlist
  include Mongoid::Document
  field :name, :type => String
  field :url, :type => String
  field :source, :type => String
  field :playlist_id, :type => String
  field :image_url, :type => String
  has_and_belongs_to_many :users
  
  def self.get_sc_followings_playlists(user_id)
    client = Soundcloud.new(:access_token => User.find(user_id).get_auth('soundcloud').token)
    playlist_array = []
    followings = client.get("/me/followings")
    followings.each do |f|
      if f.playlist_count > 0
        playlists = client.get("/users/#{f.id}/playlists")
        playlists.each do |r|
          obj = {}
          obj["username"] = f.username
          obj['name'] = r.title
          obj['image_url'] = r.artwork_url
          obj['image_url'] = r.tracks[0].artwork_url if (!r.tracks[0].blank? and obj['image_url'].nil?)
          obj['image_url'] = r.user.avatar_url if obj['image_url'].nil?
          obj['playlist_url'] = r.uri
          obj['source']= 'soundcloud'
          playlist_array << obj
        end
      end
    end
    
    return playlist_array
  end
  
end
