# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  
  $s = $('#big_search')
  $c = $('#container')
  $tc = $('#tile-container')
  player = new Player()
  is_open = false
  
  $('.item img').live('click', (e) ->
    p = $(@).parent()
    player.populate(p.attr('data-source'), p.attr('data-url'))
    if (!is_open)
      $('#playlist-grid').css('margin-right', parseInt($('#container').css('margin-right'), 10)+240)
      is_open = true
    $c.masonry('reload')
    e.preventDefault()
  )
  $('.item a.like').live('click', (e) ->
    e.preventDefault()
    if window.MIXXY.current_user?
      console.log($(@).parent().parent())
      $.post(
        '/api/like'
        {
          source: $(@).parent().parent().attr('data-source')
          url: $(@).parent().parent().attr('data-url')
          image_url: $(@).parent().parent().find('img').attr('src')
        }
        (data) ->
          console.log(data)
      )
    else
      $m = $(ich.login_modal())
      $m.modal()
    
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