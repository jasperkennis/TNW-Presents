require 'bol'

Bol.configure do |c|
  c.access_key = ENV['bol_key'] || Settings.bol_key
  c.secret = ENV['bol_secret'] || Settings.bol_secret
  c.per_page = 10
end