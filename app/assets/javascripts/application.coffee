define ['jquery'], () -> 
  
  class Suggestor
  
    interests: []
    suggestions: []
    
    constructor: ->
      @navigateTo '#start', 1
      @listen()
  
    randomInterest: ->
      @interests[ Math.floor( Math.random() * @interests.length ) ]

    listen: ->
      $('.person').on 'click', (e) =>
        e.preventDefault()
        id = $( e.currentTarget ).attr 'data-id'
        @fetchUserInterests id
    
    fetchUserInterests: ( id ) ->
      $.getJSON "user/#{ id }.json", ( data, textStatus, jqXHR ) =>
        @interests = data
        @navigateTo( "#gifts" )
        @fetchSuggestions()
    
    fetchSuggestions: ->
      $.getJSON "bol/suggestions/#{ @randomInterest() }.json", ( data, textStatus, jqXHR ) =>
        @suggestions = data
        console.log data
    
    navigateTo: ( part, speed = 500 ) ->
      $( 'body' ).animate
        scrollTop: $("#{ part }").position().top
      , speed
    
    
        
  if $('.person').length > 0
    suggestor = new Suggestor
  
  
  
  # Fuzzy search for connections!
  if $('[data-type="connection-search"]').length > 0
    $('[data-type="connection-search"]').on 'keyup', ( e ) ->
      q = $( e.currentTarget ).val().toLowerCase()
      
      if q isnt ""
        $('[data-name]').hide()
        $('[data-name*="'+q+'"]').show()
      else
        $('[data-name]').show()
        

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

    