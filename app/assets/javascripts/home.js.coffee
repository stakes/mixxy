# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  
  $s = $('#big_search')
  $c = $('#container')
  $tc = $('#tile-container')
  player = new Player()
  
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
          $i.bind('click', (e) ->
            player.populate($(@).attr('data-source'), $(@).attr('data-url'))
            e.preventDefault()
          )
        )
        
        
        $c.masonry('reload')
        
    ) 
  )
  
  
  
  $c.imagesLoaded () ->
    $c.masonry(
      itemSelector: '.item'
      isFitWidth: true
    )