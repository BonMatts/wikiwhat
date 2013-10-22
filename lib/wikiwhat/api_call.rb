require 'open-uri'
require 'rest_client'
require 'json'

module ApiCall
  class Call
    attr_accessor :title

    # Take argument title and set it as instance variable.
    #
    def initialize(title)
      @title = title
      @action = 'query'
      @prop = 'extracts'
    end

    # Make a string that is the URL for the API call.
    #
    def form_string
      @base = "http://en.wikipedia.org/w/api.php?action=#{@action}&prop=#{@prop}&format=json"
      @title = URI::encode(@title)
      @base + '&titles=' + @title
    end

    # Call the API and parse the returning JSON object.
    #
    def call_api
      JSON.parse(RestClient.get form_string)
    end
  end
end
