class Service
  include Mongoid::Document
  field :provider, :type => String
  field :token, :type => String
  field :secret, :type => String
  attr_accessible :provider, :token, :secret
end