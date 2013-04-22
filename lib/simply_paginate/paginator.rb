module SimplyPaginate
  class Paginator
    attr_reader :pages
    
    def initialize(collection)
      @collection = collection
      @pages = []
    end
    
    def paginate(limit)
      @pages = []
            
      @collection.each_slice(limit) do |slice|
        page = Page.new(slice, @pages[@pages.count - 1])
        
        @pages[@pages.count - 1].next = page unless @pages[@pages.count - 1].nil?
        
        @pages << page
      end
      
      self
    end
    
    def [](pos)
      @pages[pos]
    end
  end
end