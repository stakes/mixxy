class Playlist
  include Mongoid::Document
  field :name, :type => String
  field :url, :type => String
  field :source, :type => String
  field :playlist_id, :type => String
end
