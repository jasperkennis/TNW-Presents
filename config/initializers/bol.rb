require 'bol'

Bol.configure do |c|
  c.access_key = Settings.bol_key or ENV['bol_key']
  c.secret = Settings.bol_secret or ENV['bol_secret']
  c.per_page = 10
end