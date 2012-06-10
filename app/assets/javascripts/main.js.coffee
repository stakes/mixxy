# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->

  $s = $('#big_search')
  $c = $('#container')
  $gc = $('.item-grid-container')
  $tc = $('#tile-container')
  player = new Player()
  
  $('.item img').live('click', (e) ->
    
    e.preventDefault()
    $('.item.flip .front').children().hide()
    $('.item.flip').removeClass('flip').animate(
      {
        width: 220
        height: 260
      }
      750
      () ->
        $(@).find('.front').children().fadeIn()
    )
    p = $(@).parent()
    w = 460
    w = 700 if p.attr('data-source') == 'youtube'
    $pt = p.parent()
    $pt.addClass('flip')
    $pt.animate(
      {
        width: w
        height: 538 
      }
      750
      () ->
        if $gc.length > 0
          $gc.masonry('reload')
        else
          $c.masonry('reload')
    )
    player.destroy()
    setTimeout(
      () ->
        console.log($pt)
        console.log($pt.find('.back'))
        player.loadPlayer($pt.find('.back'), p.attr('data-source'), p.attr('data-url'))
      2000
    )
    if (!window.MIXXY.is_player_open?)
      window.MIXXY.is_player_open = true
    $c.masonry('reload')
  )
  $('.item a.like').live('click', (e) ->
    e.preventDefault()
    if window.MIXXY.current_user?
      e.addClass('liked')
      $.post(
        '/api/like'
        {
          source: $(@).parent().parent().attr('data-source')
          url: $(@).parent().parent().attr('data-url')
          image_url: $(@).parent().parent().find('img').attr('src')
          name: $(@).parent().parent().find('p').html()
        }
        (data) ->
          # TODO: visual feedback on like
          console.log(data)
      )
    else
      $m = $(ich.login_modal())
      $m.modal()
    
  )

  $c.masonry(
    itemSelector: '.item'
    isFitWidth: true
    columnWidth: 240
    isAnimated: true
  )
  
  $gc.masonry(
    itemSelector: '.item'
    isFitWidth: true
    columnWidth: 240
    isAnimated: true
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
  
  # users
  
  $playlist_modal = null
  
  $('#actions a.enabled').live('click', (e) ->
    e.preventDefault()
    s = $(@).attr('class').split(' ')[2]
    obj = { source: s }
    
    if s == 'spotify'
      $playlist_modal = $(ich.spotify_modal(obj))
      $playlist_modal.modal()
      $('#spotify-form').bind('submit', (e) ->
        e.preventDefault()
        console.log($(@).find('#uri-input').val())
        console.log($(@).find('#title-input').val())
        $.post(
          '/api/add/spotify'
          {
            source: 'spotify'
            url: $(@).find('#uri-input').val()
            image_url: '/assets/default-spotify.png'
            name: $(@).find('#title-input').val()
          }
          (data) ->
            # TODO: visual feedback on add

            window.location.reload(true)
        )
      )
    else
      $playlist_modal = $(ich.playlist_modal(obj))
      $playlist_modal.modal()
      $pl = $('#playlist-items')
      $.get(
        $(@).attr('href')
        (data) -> 
          $pl.html('')
          _.each(data, (val, key) ->
            $l = ich.playlist_list_item(val)
            $pl.prepend($l)
          )
      )    
  )
  $('#playlist-items .list-item').live('click', (e) ->
    e.preventDefault()
    $('#playlist-items .list-item').die('click').css('opacity', .4)
    $.post(
      '/api/add'
      {
        source: $(@).parent().attr('data-source')
        url: $(@).attr('data-url')
        image_url: $(@).find('img').attr('src')
        name: $(@).find('h3').html()
      }
      (data) ->
        # TODO: visual feedback on add
        
        window.location.reload(true)
    )
  )
  
  # user tabs
  

  $('#user-tabs a:first').tab('show')
  $('#user-tabs a').click((e) ->
    e.preventDefault();
    $(@).tab('show');
    $gc.masonry(
      itemSelector: '.item'
      isFitWidth: true
      columnWidth: 240
    )
  )

  