module Wikiwhat
  class WikiwhatError < StandardError
  end

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

    # Splits the content into side bar and everything else.
    # This method is for Parsing methods that use the raw markup from the
    # revisions call.
    # Specify start as 0 for sidebar content, for everything else specify
    # 'content_split(1, -1)'
    #
    # TODO:split the content from the catagory info
    def content_split(start, finish=nil)
      @content = @request.split("'''")
      if finish == nil
        @content[start]
      else
        @content[start..finish].join
      end
    end
  end

  # Extract portions of text from Wiki article
  class Text < Results

    def initialize(api_return, prop='extract')
      @request = self.pull_from_hash(api_return, prop)
      if @request.class == Array
        @request = self.pull_from_hash(@request[0], "*")
      end
    end

    # Returns the requested number of paragraphs of a Wiki article
    #
    # quantity - the Number of paragraphs to be returned starting from the top
    #            of the article. Defaults is to get the first paragraph.
    #
    # Return an array of strings.
    def paragraph(quantity)
      # Break the article into individual paragraphs and store in an array.
      start = @request.split("</p>")

      # Re-add the closing paragraph HTML tags.
      start.each do |string|
        string << "</p>"
      end

      # Check to make sure the quantity being requested is not more paragraphs
      # than exist.
      #
      # Return the correct number of paragraphs assigned to new_arr
      if start.length < quantity
        quantity = start.length - 1
        new_arr = start[0..quantity]
      else
        quantity = quantity - 1
        new_arr = start[0..quantity]
      end
    end

    # Find all paragraphs under a given heading
    #
    # header = the name of the header as a String
    # paras  = the number of paragraphs
    #
    # Return a String.
    def find_header(header)
      # Find the requested header
      start = @request.index(header)
      if start
        # Find next instance of the tag.
        end_first_tag = start + @request[start..-1].index("h2") + 3
        # Find
        start_next_tag = @request[end_first_tag..-1].index("h2") + end_first_tag - 2
        # Select substring of requested text.
        @request[end_first_tag..start_next_tag]
      else
        raise Wikiwhat::WikiwhatError.new("Sorry, that header isn't on this page.")
      end
    end

    # Removes HTML tags from a String
    #
    # string - a String that contains HTML tags.
    #
    # Returns the string without HTML tags.
    def only_text(string)
      no_html_tags = string.gsub(/<\/?.*?>/,'')
    end

    # Return the text from the sidebar, if one exists
    # def sidebar
    #   @sidebar = content_split(0)
    # end

    # Find the image from the sidebar, if one exists
    #
    # Return the url of the image as a String.
    def sidebar_image
      # Check to see if a sidebar image exists
      if self.content_split(0)[/(image).*?(\.\w\w(g|G|f|F))/]
        # Grab the sidebar image title
        image_name = self.content_split(0)[/(image).*?(\.\w\w(g|G|f|F))/]
        # Remove the 'image = ' part of the string
        image_name = image_name.split("=")[1].strip
        # Call Wikipedia for image url
        get_url = Wikiwhat::Call.call_api(('File:'+ image_name),
          :prop => "imageinfo", :iiprop => true)
        # Pull url from hash
        img_name_2 = pull_from_hash(get_url, "pages")
        img_array = pull_from_hash(img_name_2, "imageinfo")
        img_array[0]["url"]
      else
        # If no sidebar image exists, raise error.
        raise Wikiwhat::WikiwhatError.new("Sorry, it looks like there is no sidebar image
          on this page.")
      end
    end

    # Find all references on a page.
    #
    # Return all refrences as an array of arrays.
    #
    # TODO: Currently nested array, want to return as array of strings.
    def refs
      @content = content_split(1, 2)

      #add all references to an array. still in wiki markup
      @content.scan(/<ref>(.*?)<\/ref>/)
    end


  end

  class Media < Results
    attr_reader :api_return
    def initialize(api_return, prop, options={})
      @request = self.pull_from_hash(api_return, prop)
      if @request.class == Array
        @request = self.pull_from_hash(@request[0], "*")
      end
      options[:sidebarwidth]  ? @sidebarwidth  = options[:sidebarwidth]
      options[:sidebarheight] ? @sidebarheight = options[:sidebarheight]
    end

    # Find all the media items on a page.
    #
    # Return a hash containing an array of urls and an array of titles.
    def list_images
      # Call API for initial list of images
      isolated_list = @request
      # Parse JSON object for list of image titles
      image_title_array = []
      isolated_list.collect do |key, value|
        image_title_array << value["title"]
      end

      # Make API call for individual image links
      img_url_call_array = []
      image_title_array.each do |title|
        img_url_call_array << Wikiwhat::Call.call_api(title,
          :prop => "imageinfo", :iiprop => true)
      end

      # Pull pages object containing imageinfo array out from JSON object
      imageinfo_array = []
      img_url_call_array.each do |object|
        imageinfo_array << pull_from_hash(object, "pages")
      end

      # Pull imageinfo array out of nested hash
      info_array = []
      imageinfo_array.each do |object|
        info_array << pull_from_hash(object, "imageinfo")
      end

      # Pull each URL and place in an array
      url_array = []
      info_array.each do |array|
        url_array << array[0]["url"]
      end

      return {urls: url_array, titles: image_title_array }
    end

        # Find the image from the sidebar, if one exists
    #
    # Return the url of the image as a String.
    def sidebar_image_thumbnail
      # Check to see if a sidebar image exists
      if self.content_split(0)[/(image).*?(\.\w\w(g|G|f|F))/]
        # Grab the sidebar image title
        image_name = self.content_split(0)[/(image).*?(\.\w\w(g|G|f|F))/]
        # Remove the 'image = ' part of the string
        image_name = image_name.split("=")[1].strip
        # Call Wikipedia for image url
        get_url = Wikiwhat::Call.call_api(('File:'+ image_name), 
          :prop => "imageinfo", 
          :iiprop => true, 
          :iiurlwidth => @sidebarwidth, 
          :iiurlheight => @sidebarheight )
        # Pull url from hash
        img_name_2 = pull_from_hash(get_url, "pages")
        img_array = pull_from_hash(img_name_2, "imageinfo")
        img_array[0]["thumburl"]
      else
        # If no sidebar image exists, raise error.
        raise Wikiwhat::WikiwhatError.new("Sorry, it looks like there is no sidebar image
          on this page.")
      end
    end

  end
end
