class window.Player
  
  @player_obj
  @player_instance
  
  constructor: () ->
    
    @player_instance = $('#player')
    
  populate: (src, embed) ->
    if src == 'soundcloud'
      source = encodeURI(source)
    @player_obj = {
      source: src
      url: embed
    }
    @player_instance.html('')
    if src == 'rdio'
      @player_instance.append(ich.rdio_widget(@player_obj))
    if src == 'soundcloud'
      @player_instance.append(ich.soundcloud_widget(@player_obj))
    @player_instance.show()