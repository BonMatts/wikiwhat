require "wikiwhat/version"

module Wikiwhat
  class Page
    def initialize(title)
      ApiCall::Call(title)
    end

  end
end
