class User
  include Mongoid::Document
  field :provider, :type => String
  field :uid, :type => String
  field :name, :type => String
  field :email, :type => String
  attr_accessible :provider, :uid, :name, :email
  embeds_many :services
  include YTPlaylistImporter
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
    ytid = yt_id.present? ? yt_id.split('/')[-1] : nil
    self.services.build(provider: provider, token: token, secret:ytid) if !self.has_service(provider)
    self.save
  end
  
  def has_service(service)
    self.services.where('provider' => service).count == 0 ? false : true
  end
  
  def service_credentials(service)
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
    has_youtube ? youtube.auth.youtube_id : ""
  end

end

