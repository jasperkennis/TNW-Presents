require 'bol'

Bol.configure do |c|
  c.access_key = Settings.bol_key
  c.secret = Settings.bol_secret
  c.per_page = 10
end