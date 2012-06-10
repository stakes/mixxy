class Service
  include Mongoid::Document
  field :provider, :type => String
  field :token, :type => String
  field :secret, :type => String
  field :youtube_id, :type => String, :default => nil
  attr_accessible :provider, :token, :secret
end