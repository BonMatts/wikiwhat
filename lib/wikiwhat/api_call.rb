require 'open-uri'
require 'rest_client'
require 'json'

module Api
  class Call
    attr_accessor :title, :prop

    # Initialize an instance of Call
    #
    # title      - the title of the desired Wikipedia API as a String
    # prop       - the type of content as a String
    # rvprop     - True or False
    # image_list - True or False
    # iiprop     - True or False
    #
    # Set instance variables.
    def initialize(title, options={})
      @title = URI::encode(title)
      options[:prop] ? @prop = options[:prop] : @prop = ''
      options[:rvprop] ? @rvprop = "&rvprop=content" : @rvprop = ''
      options[:img_list] ? @img_list = "&generator=images" : @img_list = ''
      options[:iiprop] ? @iiprop = "&iiprop=url" : @iiprop = ''
    end

    # Make a string that is the URL for the API call for text-based requests.
    #
    def form_string
      @base = "http://en.wikipedia.org/w/api.php?action=query&prop=#{@prop}&titles=#{@title}&format=json&redirects#{@img_list}#{@rvprop}#{@iiprop}"
    end

    # Call the API and parse the returning JSON object.
    #
    def call_api
      JSON.parse(RestClient.get form_string)
    end
  end
end
