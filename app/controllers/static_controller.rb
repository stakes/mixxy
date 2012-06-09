class StaticController < ApplicationController
  def home
    
   # rdio
    rdio = RdioApi.new(:consumer_key => ENV["RDIO_APP_KEY"], :consumer_secret => ENV["RDIO_APP_SECRET"])
    rdio_pop = rdio.getHeavyRotation(:type => 'albums', :count => 12)
    
    response = []
    artists = []
    rdio_pop.each do |p|
      rdio_res = rdio.search(:query => p.artist, :types => 'playlist', :count => 4)
      rdio_res.results.each do |r|
        obj = {}
        obj['name'] = r.name
        obj['image_url'] = r.icon
        obj['playlist_url'] = r.embedUrl
        obj['source'] = 'rdio'
        response << obj
      end
    end

    response = response.sort_by { rand }
    @playlists = response
    
  end
end
