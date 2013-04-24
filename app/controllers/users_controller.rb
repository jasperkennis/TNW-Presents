class UsersController < ApplicationController
  def show
    @user_id = params[:id]
    
    create_client
    
    if cookies[:luser].nil?
      redirect_to '/'
    else
      token = Marshal.load( cookies[:luser] )
      @client.authorize_from_access( token[0], token[1])
      unless session["user-#{ @user_id.parameterize }"]
        @user = @client.profile( id: @user_id, fields: [ :summary, :headline, :first_name, :last_name, :picture_url ] )
        session["user-#{ @user_id.parameterize }"] = Marshal.dump( @user )
      else
        @user = Marshal.load( session["user-#{ @user_id.parameterize }"] )
      end
    end
  end
  
  private
    def create_client
      @client ||= LinkedIn::Client.new( Settings.linkedin_key, Settings.linkedin_secret )
    end
end
