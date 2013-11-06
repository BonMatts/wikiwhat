require 'json'
require 'wikiwhat/parse'
require 'wikiwhat/api_call'

module Wikiwhat
  class Page
    attr_reader :head, :header, :image_list, :title, :img_list,
                :sidebar_img_url, :ref_list, :paragraphs

    # Set title of article and type of information requested.
    #
    # title       - the title of the requested article as a String
    # img_list    - True if desired output is a list of all images on the page.
    # header      - the desired section header as a String.
    # refs        - True if desired output is a list of all references on the
    #               page.
    # sidebar_img - True if desired output is the image in the sidebar
    # paragraphs  - the number of paragraphs from the article as an Interger
    #
    # TODO
    # sidebar     - True if desired output is the contents of the sidebar.
    #
    # Takes options hash and sets instance variables, then calls appropriate
    # method.
    def initialize(title, options={})
      @title = title
      run(options)
    end

    # Iterates over the options hash.
    #
    # hash - options hash
    #
    # Runs the appropriate method based on the options hash.
    def run(hash)
      hash.each do |key, value|
        case key
          when:img_list
            @img_list = value
            image_list
          when:header
            @head = value
            header(value)
          when:refs
            @refs = value
            find_ref_list
          when:sidebar_img
            @sidebar_img = value
            sidebar_image
          when:num_paragraphs
            @paras = value
            paragraphs(value)
          when:sidebar
            @sidebar = value
            sidebar_image
        end
      end
    end

    def paragraphs(value = 1)
      @paragraphs ||= find_paragraphs(value)
    end

    def image_list
      @image_list ||= find_image_list
    end

    def header(header)
      @header ||= find_header(header)
    end

    def ref_list
      @ref_list ||= find_ref_list
    end

    def sidebar_image
      @sidebar_image ||= find_sidebar_image
    end

    private

    def find_paragraphs(paras)
      @paras = paras
      api_contents = Call.call_api(@title, :prop => "extracts")
      para = Text.new(api_contents)
      @paragraphs = para.paragraph(@paras)
    end

    def find_image_list
      api_contents = Call.call_api(@title, :img_list => true)
      img_list = Media.new(api_contents, 'pages')
      @image_list = img_list.list_images
    end

    def find_header(head)
      @head = head
      api_contents = Call.call_api(@title, :prop => "extracts")
      head_text = Text.new(api_contents)
      @header = head_text.find_header(@head)
    end

    def find_ref_list
      api_contents = Call.call_api(@title, :prop => "revisions", :rvprop => true)
      f_ref = Text.new(api_contents, prop = 'revisions')
      @ref_list = f_ref.refs
    end

    def find_sidebar_image
      api_contents = Call.call_api(@title, :prop => "revisions", :rvprop => true)
      side_img_name = Text.new(api_contents, prop = 'revisions')
      @sidebar_img_url = side_img_name.sidebar_image
    end
  end
end
