class window.Player
  
  @player_obj
  @player_instance
  
  constructor: () ->
    
    @player_instance = $('#player')
    
  populate: (src, embed) ->
    @player_obj = {
      source: src
      url: embed
    }
    @player_instance.html('')
    @player_instance.append(ich.player_widget(@player_obj))