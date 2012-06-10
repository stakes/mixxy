class StaticController < ApplicationController
  def home
    
   # rdio
    rdio = RdioApi.new(:consumer_key => ENV["RDIO_APP_KEY"], :consumer_secret => ENV["RDIO_APP_SECRET"])
    rdio_pop = rdio.getHeavyRotation(:type => 'albums', :count => 20)
    
    artists = rdio_pop.sort_by { rand }
    artists.slice!(0, 7)
    
    response = []
    
    artists.each do |p|
      # Rdio
      rdio_res = rdio.search(:query => p.artist, :types => 'playlist', :count => 4)
      rdio_res.results.each do |r|
        obj = {}
        obj['name'] = r.name
        obj['image_url'] = r.icon
        obj['playlist_url'] = r.embedUrl
        obj['source'] = 'rdio'
        response << obj
      end
      # YouTube
      feed = HTTParty.get("https://gdata.youtube.com/feeds/api/playlists/snippets?v=2&q=#{URI::encode(p.artist)}&max-results=2", :format => :xml)
      feed['feed']['entry'].each do |entry| 
        response << {
          'source' => 'youtube',
          'playlist-url' => entry['link'][entry['link'].index {|l| l['rel']=='self'}]['href'],
          'name' => entry['title'],
          'image_url' => entry['media:group']['media:thumbnail'][2]['url']
          # 'username' => youtube_username
        }
      end
    end

    response = response.sort_by { rand }
    @playlists = response
    
  end
end
