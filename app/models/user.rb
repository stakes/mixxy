class User
  include Mongoid::Document
  field :provider, :type => String
  field :uid, :type => String
  field :name, :type => String
  field :email, :type => String
  attr_accessible :provider, :uid, :name, :email
  embeds_many :services

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
  
  def add_service_with_omniauth(provider, token, secret)
    self.services.build(provider: provider, token: token, secret: secret)
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

