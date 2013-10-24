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
    def paragraph
      @start = @request.split("</p>")[0]
      @start = @start.split("<p>")[1]
      return @start
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

    # Return the text from the sidebar, if one exists
    def sidebar
      @sidebar = content_split(0)

    end

    # Return all refrences
    def refs
      @content = content_split(1, 2)
    
      #add all references to an array. this does not work
      @refs = @content.match(/<ref>(.*?)<\/ref>/)

    end

    # Return all paragraphs under a given heading
    def header(name)
    end


    def content_split(start, finish=nil)
      @content = @request.split("'''")
      if finish == nil
        return @content[start]
      else
        return @content[start..finish].join
    end 


  end

  class Media < Results
    def images
    end
  end
end