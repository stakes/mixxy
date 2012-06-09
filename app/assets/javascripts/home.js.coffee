# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  
  
  $s = $('#big_search')
  $c = $('#container')
  $tc = $('#tile-container')
  
  $s.submit((e) ->
    e.preventDefault()   
    $('.item', $tc).remove()
    
    $.post(
    
      '/api/blended_search'
      {query: $(@).find('input[type="text"]').val()}
      (data) ->
        _.each(data, (val, key) ->
          $tc.prepend(ich.playlist_tile(val))
        )
        $c.masonry('reload')
    ) 
  )
  
  
  
  $c.imagesLoaded () ->
    $c.masonry(
      itemSelector: '.item'
      isFitWidth: true
      isAnimated: true
    )