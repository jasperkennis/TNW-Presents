class PagesController < ApplicationController
  def home
    @linkedinvalid = false
    create_client
    
    if cookies[:luser].nil?
      request_token = @client.request_token(oauth_callback: ENV['redirect_url'] || Settings.redirect_url )
      rtoken = request_token.token
      
      if params[:oauth_verifier].nil?
        session[:rsecret] = request_token.secret
        @oauth_url = request_token.authorize_url
        @page = 'beforelinkedin'
      else
        token = @client.authorize_from_request( params[:oauth_token], session[:rsecret], params[:oauth_verifier] )
        cookies[:luser] = Marshal.dump( token )
        redirect_to '/'
      end
    else
      @linkedinvalid = true
      token = Marshal.load( cookies[:luser] )
      @client.authorize_from_access( token[0], token[1])
      unless session[:connections]
        @connections = @client.connections( fields: [ 'picture-urls::(100x100)', :first_name, :last_name ])
        session[:connections] = Marshal.dump( @connections )
      else
        @connections = Marshal.load( session[:connections] )
      end      
    end
  end

  private
    def create_client
      @client ||= LinkedIn::Client.new( ( ENV['linkedin_key'] || Settings.linkedin_key ), ( ENV['linkedin_secret'] || Settings.linkedin_secret) )
    end
end
