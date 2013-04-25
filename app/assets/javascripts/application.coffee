define ['jquery'], () -> 
  
  # Fuzzy search for connections!
  if $('[data-type="connection-search"]').length > 0
    $('[data-type="connection-search"]').on 'keyup', ( e ) ->
      q = $( e.currentTarget ).val().toLowerCase()
      
      if q isnt ""
        $('[data-name]').hide()
        $('[data-name*="'+q+'"]').show()
      else
        $('[data-name]').show()
  
  
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
    anchor = $(this).attr 'href'

    #TODO: Track GA

    $('.gift').addClass 'send'
    setTimeout ->
      window.location = anchor
    , 3600

    