class PagesController < ApplicationController
  def home
    client = LinkedIn::Client.new( Settings.linkedin_key, Settings.linkedin_secret )
    rtoken = client.request_token.token
    rsecret = client.request_token.secret
    
    # to test from your desktop, open the following url in your browser
    # and record the pin it gives you
    client.request_token.authorize_url
#     => "https://api.linkedin.com/uas/oauth/authorize?oauth_token=<generated_token>"
    
    # then fetch your access keys
    client.authorize_from_request(rtoken, rsecret, pin)
#     => ["OU812", "8675309"] # <= save these for future requests
    
    # or authorize from previously fetched access keys
#     client.authorize_from_access("OU812", "8675309")
    
    # you're now free to move about the cabin, call any API method
  end
end
