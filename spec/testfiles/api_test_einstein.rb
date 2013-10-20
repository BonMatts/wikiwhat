require 'json'
require 'rest_client'


def testoutput
JSON.parse(RestClient.get "http://en.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&titles=Albert%20Einstein")
end
