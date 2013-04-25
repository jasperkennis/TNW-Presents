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
        @suggestion_attempts = 0
        @fetchSuggestions()
    
    fetchSuggestions: ->
      if @suggestion_attempts < 4
        $.getJSON "bol/suggestions/#{ @randomInterest() }.json", ( data, textStatus, jqXHR ) =>
          @suggestions = data
          @addSuggestions()
        .fail (jqxhr, textStatus, error ) =>
          @suggestion_attempts++
          @fetchSuggestions()
      else
        alert 'Sorry, we couldn\'t find any suggestions for this person.'
    
    addSuggestions: ->
      $('.gift-result').each ( i, e ) =>
        $( e ).find( 'h4' ).text @suggestions[i].attributes.title
        $( e ).find( 'p' ).text @suggestions[i].attributes.short_description
        $( e ).find( 'span.price' ).text "€ #{ @suggestions[i].attributes.offers[0].table.price }"
        $( e ).find( '.gift-preview' ).css
          'background-image': "url( #{ @suggestions[i].attributes.cover.extra_large })"
        $( e ).find( '.btn.buy' ).attr 'href', @suggestions[i].attributes.url
      $( '#gifts' ).removeClass 'loading'
    
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

    