define ['jquery'], () -> 
  
  # Fuzzy search for connections!
  if $('[data-type="connection-search"]').length > 0
    $('[data-type="connection-search"]').on 'keyup', ( e ) ->
      q = $( e.currentTarget ).val().toLowerCase()
      
      if q isnt ""
        $('[data-name]').addClass 'hidden'
        $('[data-name*="'+q+'"]').removeClass 'hidden'
      else
        $('[data-name]').removeClass 'hidden'
  
  
  if $('.person').length > 0
    $('.person').on 'click', (e) ->
      e.preventDefault()
      id = $( e.currentTarget ).attr 'data-id'
      $.getJSON "user/#{ id }.json", ( data, textStatus, jqXHR ) ->
        console.log data

  # Toggle gift info
  $('i.icon-info').on 'click', ( e ) ->
    $(this).parent().toggleClass 'open'

  # Set each .page to screen height
  $('.page').css minHeight: $(window).height()

  # Track GA and trigger animation for purchase button
  $('[data-type="purchase"]').on 'click', ( e ) ->
    e.preventDefault();
    #TODO: Track GA
    $('.gift').addClass 'send'
    