require "wikiwhat/version"
require 'json'
require 'wikiwhat/parse'
require 'wikiwhat/api_call'

class Wikiwhat
  class Page
    # Include module for calling Wikipedia API.
    include Api
    # Include modeule for parsing Wikipedia content from Wikipedia API.
    include Parse

    # Set title of article and type of information requested.
    #
    # title       - the title of the requested article as a String
    # img_list    - True if desired output is a list of all images on the page.
    # header      - the desired section header as a String.
    # refs        - True if desired output is a list of all references on the page.
    # sidebar_img - True if desired output is the image in the sidebar
    # paragraphs  - the number of paragraphs from the article as an Interger
    # sidebar     - True if desired output is the contents of the sidebar.
    #
    # Takes options hash and sets instance variables, then calls appropriate method.
    def initialize(title, options={})
      @title = title
      # @img_list
      # @head
      # @refs
      # @sidebar_img
      # @paras
      # @sidebar
      run(options)
    end

    # Iterates over the options hash.
    #
    # hash - options hash
    #
    # Runs the appropriate method based on the options hash.
    def run(hash)
      hash.each do |key, value|
        if key == :img_list
          @img_list = value
          find_image_list
        elsif key == :header
          @head = value
          find_header
        elsif key == :refs
          @refs = value
          find_refs
        elsif key == :sidebar_img
          @sidebar_img = value
          find_sidebar_img
        elsif key == :paragraphs
          @paras = value
          find_paragraphs
        elsif key == :sidebar
          @sidebar = value
          find_sidebar
        end
      end
    end


    def find_paragraphs
      find_para = Call.new(@title, :prop => "extracts")
      api_contents = find_para.call_api

      para = Text.new(api_contents)
      @paragraphs = para.paragraph(@paras || 1)
    end

    def find_image_list
      find_img_list = Call.new(@title, :img_list => true)
      api_contents = find_img_list.call_api
      img_list = Media.new(api_contents, 'pages')
      @image_list = img_list.list_images
    end

    def find_header
      find_head = Call.new(@title, :prop => "extracts")
      api_contents = find_head.call_api

      head_text = Text.new(api_contents)
      @header = head_text.find_header(@head)
    end

    def find_refs
      find_ref = Call.new(@title, :prop => "revisions", :rvprop => true)
      api_contents = find_ref.call_api

      f_ref = Text.new(api_contents, prop = '')
      @refs = f_ref.refs
    end

    def find_sidebar_img
      find_ref = Call.new(@title, :prop => "revisions", :rvprop => true)
      api_contents = find_ref.call_api

      side_img_name = Text.new(api_contents, prop = '')
      @sidebar_img = side_img_name.sidebar_img
    end

    # def find_sidebar
    #   find_ref = Call.new(@title, prop => "revisions", rvprop => true)
    #   api_contents = find_para.call_api
    # end
  end
end
