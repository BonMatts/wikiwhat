require 'open-uri'
require 'RestClient'

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
      
    end
  end
end
