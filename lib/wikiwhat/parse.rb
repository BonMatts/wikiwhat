module Parse

  class Results
    def initialize
      @result = nil
    end

    def pull_from_hash(hash, key)
      @hash = hash
      @key = key

      if @hash.include?(@key)
        @result = @hash[@key]
      else
        @hash.each_pair do |k, v|
          if v.class == Hash
            pull_from_hash(v, @key)
          end
        end
      end
      @result
    end
  end

  # Extract portions of text from Wiki article
  class Text < Results
    def initialize(request)
      @request = self.pull_from_hash(request, "extract")
    end

    # Returns first paragraph of the Wiki article
    #
    # TODO: refactor to take number of paragraphs as argument
    def paragraph
      @start = @request.split("</p>")[0]
      @start = @start.split("<p>")[1]
      return @start
    end

    # Return the text from the sidebar, if one exists
    def sidebar
    end

    # Return all refrences
    def refs
    end

    # Return all paragraphs under a given heading
    def header(name)
    end

    # Returns user-defined number of words before and/or a user-defined search term.
    def search(term, words, options={})
    end
  end

  class Media < Results
    def images
    end
  end
end