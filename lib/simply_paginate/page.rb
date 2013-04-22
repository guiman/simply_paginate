module SimplyPaginate
  class Page
    attr_reader :next_page, :previous_page
    
    def initialize(collection, previous_page = nil, next_page = nil)
      @collection = collection
      @next_page = next_page
      @previous_page = previous_page
    end
    
    def [](pos)
      @collection[pos]
    end
    
    def each(&block)
      @collection.each(&block)
    end
    
    def current
      self
    end
    
    def next
      @next_page
    end
    
    def previous
      @previous_page
    end
    
    def next=(v)
      @next_page = v
    end
    
    def previous=(v)
      @previous_page = v
    end
    
    def elements
      @collection
    end
  end
end