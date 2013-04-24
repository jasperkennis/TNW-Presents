class PagesController < ApplicationController
  def home
#     unless params[:code].nil? or params[:code].empty?
#       require 'net/http'
#       url = URI.parse( "https://www.linkedin.com/uas/oauth2/accessToken?grant_type=authorization_code&code=#{ params[:code] }&redirect_uri=#{ Settings.redirect_url }&client_id=#{ Settings.linkedin_key }&client_secret=#{ Settings.linkedin_secret }" )
#       resp, data = Net::HTTP.get( url )
#       raise data.inspect
#     end
    if session[:luser].nil?
      create_client
      @rtoken = @client.request_token.token
      @rsecret = @client.request_token.secret
      
      # to test from your desktop, open the following url in your browser
      # and record the pin it gives you
      if params[:pin].nil?
  #     raise @client.inspect
        @oauth_url = @client.request_token.authorize_url
      else
        token = @client.authorize_from_request( params[:pintoken], params[:pinsecret], params[:pin] )
        session[:luser] = token.serialize
      end
    end
    
    # then fetch your access keys
#     client.authorize_from_request(@rtoken, @rsecret, pin)
#     => ["OU812", "8675309"] # <= save these for future requests
    
    # or authorize from previously fetched access keys
#     client.authorize_from_access("OU812", "8675309")
    
    # you're now free to move about the cabin, call any API method
  end
  
  def authorize
    
  end
  
  private
    def create_client
      @client ||= LinkedIn::Client.new( Settings.linkedin_key, Settings.linkedin_secret )
    end
end
