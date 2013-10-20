require 'open-uri'
require 'rest_client'
require 'json'

module ApiCall
  class Call
    attr_accessor :title

    def initialize(title)
      @title = title
      @action = 'query'
      @prop = 'extracts'
    end

    def form_string
      @base = "http://en.wikipedia.org/w/api.php?action=#{@action}&prop=#{@prop}&format=json"
      @title = URI::encode(@title)
      @base + '&titles=' + @title
    end

    def call_api
      JSON.parse(RestClient.get form_string)
    end
  end
end
