require "wikiwhat/version"
require 'json'
require 'wikiwhat/parse'
require 'wikiwhat/api_call'

class Wikiwhat
  # Creates a new ApiCall::Call instance,
  # Calls ApiCall:Call #call_api
  # calls parse (see self.parse comments)
  #
  # title - the title of the wikipedia article as a string
  #
  # returns first paragraph of article
  def self.call(title)
    request = ApiCall::Call.new(title)
    api_return = request.call_api
    parse(api_return)
  end

  def self.parse(api_return)
    @para = Parse::Text.new(api_return)
    @para.paragraph
  end

  def reference_sidebar
    raw = ApiCall::Call.new(title, 'revisions&rvprop=content')
    base = Parse::Text.new(raw)
end
