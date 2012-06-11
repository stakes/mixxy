module YTPlaylistImporter
  def youtube_playlists
    feed = HTTParty.get("https://gdata.youtube.com/feeds/api/users/#{self.youtube_id}/playlists?v=2&alt=json").parsed_response
    playlists = []
    feed['feed']['entry'].each {|entry| playlists << {
      'source' => 'youtube',
      'playlist_url' => entry['link'][entry['link'].index {|l| l['rel']=='self'}]['href'],
      'name' => entry['title']['$t'],
      'image_url' => entry['media$group']['media$thumbnail'][2]['url'],
      'username' => youtube_username
    }}
    playlists
    
  end
  
  def youtube_username
    feed = HTTParty.get("https://gdata.youtube.com/feeds/api/users/#{self.youtube_id}?v=2&alt=json").parsed_response
    feed['entry']['yt$username']['$t']
  end
end