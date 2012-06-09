class ApiController < ApplicationController

  def blended_playlist_search
    
    q = params[:query]
      
    response = []
      
    # Mixxy playlists - later
      
    # rdio
    rdio = RdioApi.new(:consumer_key => ENV["RDIO_APP_KEY"], :consumer_secret => ENV["RDIO_APP_SECRET"])
    rdio_res = rdio.search(:query => q, :types => 'playlist', :count => 10)
    # normalize
    rdio_res.results.each do |r|
      obj = {}
      obj['name'] = r.name
      obj['image_url'] = r.icon
      obj['playlist_url'] = r.embed_url
      response << obj
    end
    
    # soundcloud
    
    
    # youtubes - LAST
    
    
    # blend results
    
    render :json => response.to_json
    
  end
  
end