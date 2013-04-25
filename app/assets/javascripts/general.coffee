imageDimensions = {
  w: 0,
  h: 0,
  r: 0
}

class Suggestor

  interests: []
  suggestions: []
  
  constructor: ->
    @navigateTo '#start', 1
    @listen()

  randomInterest: ->
    @interests[ Math.floor( Math.random() * @interests.length ) ]

  listen: ->
    $( '.person' ).on 'click', (e) =>
      e.preventDefault()
      id = $( e.currentTarget ).attr 'data-id'
      @fetchUserInterests id
      
    $( '#load-more' ).on 'click', ( e ) =>
      e.preventDefault()
      @loadMore()
      
    $( '.gift-result .btn.buy' ).on 'click', ( e ) =>
      e.preventDefault()
      index = $( e.currentTarget ).attr 'data-index'
      @packOrder( index )
      
  
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
      $( e ).find( '.desc' ).text @suggestions[i].attributes.short_description
      $( e ).find( 'span.price' ).text "€ #{ @suggestions[i].attributes.offers[0].table.price }"
      $( e ).find( '.gift-preview' ).css
        'background-image': "url( #{ @suggestions[i].attributes.cover.extra_large })"
      $( e ).find( '.btn.buy' ).attr 'href', @suggestions[i].attributes.url
      $( e ).find( '.btn.buy' ).attr 'data-index', i
    $( '#gifts' ).removeClass 'loading'
  
  loadMore: ->
    @suggestion_attempts = 0
    $( '#gifts' ).addClass 'loading'
    @fetchSuggestions()
  
  navigateTo: ( part, speed = 500 ) ->
    $("#{ part }").show()
    $( 'body' ).animate
      scrollTop: $("#{ part }").position().top
    , speed

    if part isnt "#start"
      $( '.fade' ).fadeOut()
    
  packOrder: ( index ) ->
    @navigateTo '#pack'

    affiliateURL = "http://partnerprogramma.bol.com/click/click?p=1&t=url&f=API&s=20243&subid=" + @suggestions[index].attributes.id + "&url=" + encodeURI(@suggestions[index].attributes.url) + "&name=" + encodeURI( @suggestions[index].attributes.title ) 
    $( '.gift-image' ).attr 'src', @suggestions[index].attributes.cover.extra_large
    $( '#actual-buy' ).attr 'href', affiliateURL

    newImage = new Image
    $( newImage ).load ->
      imageDimensions.w = newImage.width
      imageDimensions.h = newImage.height
      imageDimensions.r = newImage.width / newImage.height
      $( '.gift-image' ).css 'marginLeft': Math.round ( 300 * imageDimensions.r ) * -0.5


    newImage.src = @suggestions[index].attributes.cover.extra_large
  
  
$ ->      
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
  
    $( '.gift-image' ).css 'marginLeft': Math.round ( 100 * imageDimensions.r ) * -0.5
    #TODO: Track GA
  
    $('.gift').addClass 'send'
    setTimeout ->
      window.location = anchor
    , 3600
    