class ApiController < ApplicationController

  def blended_playlist_search
    
    q = params[:query]
      
    response = []
      
    # Mixxy playlists - later

    # rdio
    rdio = RdioApi.new(:consumer_key => ENV["RDIO_APP_KEY"], :consumer_secret => ENV["RDIO_APP_SECRET"])
    rdio_res = rdio.search(:query => q, :types => 'playlist', :count => 12)
    # normalize
    rdio_res.results.each do |r|
      obj = {}
      obj['name'] = r.name
      obj['image_url'] = r.icon
      obj['playlist_url'] = r.embedUrl
      obj['source'] = 'rdio'
      response << obj
    end
    
    # soundcloud
    soundcloud = Soundcloud.new(:client_id => ENV["SC_APP_ID"])
    sc_res = soundcloud.get('/playlists', :q => q, :limit => 12)
    sc_res.each do |r|
      obj = {}
      obj['name'] = r.title
      obj['image_url'] = r.artwork_url
      obj['image_url'] = r.tracks[0].artwork_url if !r.tracks[0].blank?
      obj['playlist_url'] = r.uri
      obj['source'] = 'soundcloud'
      response << obj
    end
    response = response.sort_by { rand }
    
    
    # youtubes - LAST
    
    
    # blend results
    
    render :json => response.to_json
    
  end
  
  def like_playlist
    
    current_user.like_playlist(params[:source], params[:url], params[:image_url])
    render :json => {:resp => 'ok'}
    
  end
  
end