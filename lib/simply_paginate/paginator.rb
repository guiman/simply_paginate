module SimplyPaginate
  class Paginator
    attr_reader :pages, :collection

    def initialize(collection)
      @collection = collection
      @pages = []
    end

    def paginate(limit)
      @pages = []
      first = last = 0
      count = limit - 1
      final_index = @collection.count - 1

      (@collection.count.to_f / limit.to_f).ceil.times do
        last = (last <= final_index) ? first + count : final_index

        page = Page.new(first, last, self, @pages[@pages.count - 1])
        @pages[@pages.count - 1].next = page unless @pages[@pages.count - 1].nil?

        @pages << page
        first = last + 1
      end

      self
    end

    def [](pos)
      @pages[pos]
    end
  end
end
