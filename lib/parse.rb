module Parse

  # Extract portions of text from Wiki article
  class Text

    # Returns first paragraph of the Wiki article
    #
    # TODO: refactor to take number of paragraphs as argument
    def paragraph
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

  class Media
    def images
    end
  end
end