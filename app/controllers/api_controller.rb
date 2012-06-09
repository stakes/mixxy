class ApiController < ApplicationController

  def blended_playlist_search
    
    q = params[:query]
      
    rdio = RdioApi.new(:consumer_key => ENV["RDIO_APP_KEY"], :consumer_secret => ENV["RDIO_APP_SECRET"])
    
    rdio_res = rdio.search(:query => q, :types => 'playlist', :count => 10)
    
    render :json => rdio_res.to_json
    
  end
  
end