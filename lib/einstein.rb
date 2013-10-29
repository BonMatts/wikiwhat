require 'rubygems'
require 'json'
require 'rest_client'

test = JSON.parse(RestClient.get "http://en.wikipedia.org/w/api.php?action=query&prop=extracts&titles=Albert%20Einstein&format=json")

output = File.open( "einstein_extract_full_text_json.rb" )
output << test
output.close