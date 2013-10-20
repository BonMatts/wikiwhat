require "wikiwhat/version"
require 'json'
require ''

  class Wikiwhat
    # def initialize(title)
    #   @request = ApiCall::Call.new(title)
    # end

    def call(title)
      @request = ApiCall::Call.new(title)
  
      @request = @request.call_api
      parse(@request)
    end


    def parse(request)
      @para = Parse::Text.new(request)
      @para.paragraph
    end
  end
