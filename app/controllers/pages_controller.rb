class PagesController < ApplicationController
  def home
    @linkedinvalid = false
    create_client
    
    if cookies[:luser].nil?
      request_token = @client.request_token(oauth_callback: 'http://0.0.0.0:3000')
      rtoken = request_token.token
      rsecret = request_token.secret
      
      if params[:oauth_verifier].nil?
        @oauth_url = request_token.authorize_url # Add scope
        @page = 'beforelinkedin'
      else
        token = @client.authorize_from_request( params[:oauth_token], session[:rsecret], params[:oauth_verifier] )
        cookies[:luser] =  Marshal.dump( token )
        redirect_to '/'
      end
    else
      @linkedinvalid = true
      token = Marshal.load( cookies[:luser] )
      @client.authorize_from_access( token[0], token[1])
      @profile = @client.profile
#       @connections = @client.connections
    end
  end
  
  def authorize
    
  end
  
  private
    def create_client
      @client ||= LinkedIn::Client.new( Settings.linkedin_key, Settings.linkedin_secret )
    end
end
