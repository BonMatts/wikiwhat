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
    attr_reader :request
    def initialize(request, prop='extract')
      @request = self.pull_from_hash(request, prop)
      if @request.class == Array
        @request = self.pull_from_hash(@request[0], "*")
      end
    end

    # Returns first paragraph of the Wiki article
    #
    # TODO: refactor to take number of paragraphs as argument
    def paragraph(quantity)
      start = request.split("</p>")

      start.each do |string|
        string << "</p>"
      end

      quantity = quantity - 1
      new_arr = start[0..quantity]
    end

    # Removes HTML tags from a String
    #
    # string - a String that contains HTML tags.
    #
    # Returns the string without HTML tags.
    def only_text(string)
      no_html_tags = string.gsub(/<\/?.*?>/,'')
    end

    def wikitext_sections
      
    end

    # Return the image from the sidebar, if one exists
    def sidebar_image
      @sidebar_image = content_split(0)[/(?<= image = )\S*/].chomp
    end

    # Return all refrences as an array
    def refs
      @content = content_split(1, 2)
    
      #add all references to an array. still in wiki markup
      @refs = @content.scan(/<ref>(.*?)<\/ref>/)
     @refs

    end

    # Return all paragraphs under a given heading
    #
    def find_header(header)
      # Find the requested header
      start = @request.index(header)
      # Find next instance of the tag.
      end_first_tag = start + @request[start..-1].index("h2") + 3
      # Find
      start_next_tag = @request[end_first_tag..-1].index("h2") + end_first_tag - 2
      # Select substring of requested text.
      section =  @request[end_first_tag..start_next_tag]
    end

    # splits the content into side bar and everything else. 
    # this method is for Parsing methods that use the raw markup from the revisions call.
    # specify start as 0 for sidebar content, for everything else specify 1 ..2
    # TODO:split the content from the catagory info
    def content_split(start, finish=nil)
      @content = @request.split("'''")
      if finish == nil
        return @content[start]
      else
        return @content[start..finish].join
      end
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
