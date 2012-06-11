class User
  include Mongoid::Document
  field :provider, :type => String
  field :uid, :type => String
  field :name, :type => String
  field :email, :type => String
  field :likes, :type => Array, :default => []
  attr_accessible :provider, :uid, :name, :email
  embeds_many :services
  include YTPlaylistImporter
  has_and_belongs_to_many :playlists
  
  after_create :send_message

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
      end
    end
  end
  
  def add_service_with_omniauth(provider, token, secret, yt_id=nil)
    p "User model: youtube_id is #{yt_id}"
    ytid = yt_id.present? ? yt_id.split('/')[-1] : nil
    self.services.build(provider: provider, token: token, secret:secret, youtube_id:ytid) if !self.has_service(provider)
    self.save
  end

  def has_playlist(url)
    self.playlists.where('url' => url).exists? ? true : false
  end
  
  def like_playlist(source, url, image_url, name)

    p = Playlist.where(url: url).first
    p = Playlist.create(source: source, url: url, image_url: image_url, name: name) if p.blank?
    
    begin
      @graph = Koala::Facebook::GraphAPI.new(self.get_auth('facebook').token)
      @graph.put_connections("me", "mixxyapp:star", :playlist => "http://mixxy.co/playlists/#{p.id.to_s}")
    rescue
    end
    self.likes << p.id if !self.likes.include?(p.id)
    self.save
    
  end
  
  def add_playlist(source, url, image_url, name)

    p = Playlist.where(url: url).first
    if p.blank?
      p = Playlist.create(source: source, url: url, image_url: image_url, name: name, owner_id: self.id) 
      self.playlists << p
    else
      p = like_playlist(source, url, image_url, name)
    end
    begin
      @graph = Koala::Facebook::GraphAPI.new(self.get_auth('facebook').token)
      @graph.put_connections("me", "mixxyapp:add", :playlist => "http://mixxy.co/playlists/#{p.id.to_s}")
    rescue
    
    end
    self.save
    
  end    
  
  def has_service(service)
    self.services.where('provider' => service).exists? ? true : false
  end
  
  def get_auth(service)
    s = self.services.where('provider' => service).first
  end

  def has_soundcloud
    self.services.where('provider' => 'soundcloud').exists? ? true : false
  end
  
  def has_youtube
    self.services.where(provider:'youtube').exists? ? true : false
  end
  
  def youtube_auth 
    self.has_youtube ? self.services.where(provider:'youtube').first : nil
  end
  
  def youtube_id
    has_youtube ? youtube_auth.youtube_id : ""
  end
  
  def send_message
    Support.welcome_to_mixxy(self).deliver
  end
end

