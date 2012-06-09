# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  
  
  $s = $('#big_search')
  $s.submit((e) ->
    e.preventDefault()   
    
    $.post(
      '/api/blended_search'
      {query: $(@).find('input[type="text"]').val()}
      (data) ->
        console.log(data)
    ) 
  )
  
  
  $c = $('#container')
  $c.imagesLoaded () ->
    $c.masonry(
      itemSelector: '.item'
      isFitWidth: true
      isAnimated: true
    )