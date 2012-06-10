class window.Player
  
  @player_obj
  @player_instance
  
  constructor: () ->
    
    @player_instance = $('#player')
    
  attach: (tgt, src, embed) ->
    @.destroy()
    @.loadPlayer(tgt, src, embed)
    setTimeout(
      () ->
        @.loadPlayer(tgt, src, embed)
      1500
    )
    
  loadPlayer: (tgt, src, embed) ->
    @player_instance = tgt
    if src == 'soundcloud'
      source = encodeURI(source)
    @player_obj = {
      source: src
      url: embed
    }
    tgt.html('')
    if src == 'rdio'
      tgt.append(ich.rdio_widget(@player_obj))
    if src == 'soundcloud'
      tgt.append(ich.soundcloud_widget(@player_obj))
    if src == 'youtube'
      tgt.append(ich.youtube_widget(@player_obj))
    

  destroy: () ->
    @player_instance.html('')