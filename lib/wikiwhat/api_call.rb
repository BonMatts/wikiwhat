require 'open-uri'
require 'rest_client'
require 'json'

module ApiCall
  class Call
    attr_accessor :title

    # Initialize an instance of Call
    #
    # title  - the title of the desired Wikipedia API as a String
    # prop   -
    # action -
    #
    # Set instance variables.
    def initialize(title, prop='extracts', action='query', options={})
      @title = URI::encode(title)
      @action = action
      @prop = prop
      img_list ? @img_list = "&generator=images" : @img_list = ''
    end

    # Make a string that is the URL for the API call for text-based requests.
    #
    def form_string
      @base = "http://en.wikipedia.org/w/api.php?action=#{@action}&prop=#{@prop}&titles=#{@title}&format=json&redirects#{@img_list}"
    end

    # Make a string that is the URL for the API call for a list of images.
    #
    def form_string_img_list
      @base = "http://en.wikipedia.org/w/api.php?action=query&generator=images&titles=#{@title}&format=json"
    end

    def 
      
    end

    # Call the API and parse the returning JSON object.
    #
    def call_api
      JSON.parse(RestClient.get form_string)
    end
  end
end
