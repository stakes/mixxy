# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  
  $s = $('#big_search')
  $c = $('#container')
  $tc = $('#tile-container')
  player = new Player()
  is_open = false
  
  $('.item').live('click', (e) ->
    player.populate($(@).attr('data-source'), $(@).attr('data-url'))
    if (!is_open)
      $('#playlist-grid').css('margin-right', parseInt($('#container').css('margin-right'), 10)+240)
      is_open = true
    $c.masonry('reload')
    e.preventDefault()
  )
  
  $s.submit((e) ->
    e.preventDefault()   
    $('.item', $tc).remove()
    
    $.post(
    
      '/api/blended_search'
      {query: $(@).find('input[type="text"]').val()}
      (data) ->
        
        # console.log(data)
        _.each(data, (val, key) ->
          $i = ich.playlist_tile(val)
          $tc.prepend($i)
        )
        
        
        $c.masonry('reload')
        
    ) 
  )
  
  
  
  $c.imagesLoaded () ->
    $c.masonry(
      itemSelector: '.item'
      isFitWidth: true
    )