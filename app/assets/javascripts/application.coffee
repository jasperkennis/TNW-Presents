define ['jquery'], () -> 
  
  # Fuzzy search for connections!
  $('[data-type="connection-search"]').on 'keyup', ( e ) ->
    q = $( e.currentTarget ).val().toLowerCase()
    
    if q != ""
      $('[data-name]').addClass 'hidden'
      $('[data-name*="'+q+'"]').removeClass 'hidden'
    else
      $('[data-name]').removeClass 'hidden'


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

    