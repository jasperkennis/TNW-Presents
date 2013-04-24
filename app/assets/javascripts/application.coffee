define ['jquery'], () -> 
  
  # Fuzzy search for connections!
  $('.big-search').on 'keyup', ( e ) ->
    q = $(this).val().toLowerCase()
    
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