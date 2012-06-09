class User
  include Mongoid::Document
  field :provider, :type => String
  field :uid, :type => String
  field :name, :type => String
  field :email, :type => String
  field :likes, :type => Array, :default => []
  attr_accessible :provider, :uid, :name, :email
  embeds_many :services
  has_and_belongs_to_many :playlists

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
  
  def has_playlist(url)
    self.playlists.where('url' => url).count == 0 ? false : true
  end
  
  def like_playlist(source, url, image_url)

    p = Playlist.where(url: url).first
    p = Playlist.create(source: source, url: url, image_url: image_url) if p.blank?

    self.likes << p.id if !self.likes.include?(p.id)
    self.save
    
  end
  
  def add_service_with_omniauth(provider, token, secret)
    self.services.build(provider: provider, token: token, secret: secret) if !self.has_service(provider)
    self.save
  end
  
  def has_service(service)
    self.services.where('provider' => service).count == 0 ? false : true
  end
  
  def service_credentials(service)
    s = self.services.where('provider' => service).first
  end

  def has_soundcloud
    self.services.where('provider' => 'soundcloud').count == 0 ? false : true
  end

end

