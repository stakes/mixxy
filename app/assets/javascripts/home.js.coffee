# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  
  
  $s = $('#big_search')
  $s.submit((e) ->
    e.preventDefault()    
    console.log($(@).find('input[type="text"]').val())
  )
  
  
  $c = $('#container')
  $c.imagesLoaded () ->
    $c.masonry(
      itemSelector: '.item'
      isFitWidth: true
      isAnimated: true
    )