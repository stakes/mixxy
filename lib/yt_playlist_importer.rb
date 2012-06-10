module YTPlaylistImporter
  def youtube_playlists
    feed = HTTParty.get("https://gdata.youtube.com/feeds/api/users/#{self.youtube_id}/playlists?v=2&alt=json").parsed_response
    
    
  end
end