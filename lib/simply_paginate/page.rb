module SimplyPaginate
  class Page
    attr_reader :index, :collection, :size

    def initialize(page, collection, size = Paginator.per_page)
      @index = page
      @collection = collection
      @size = size

      @move_page = lambda do |number|
        new_index = @index + number
        Page.new(new_index, @collection, @size) unless (new_index == 0) || (new_index > (@collection.count.to_f / @size.to_f).ceil)
      end
    end

    def next
      @move_page.call(1)
    end

    def previous
      @move_page.call(-1)
    end

    def elements
      first = (@index - 1) * @size
      last = first + size - 1

      collection[first..last]
    end

    def ==(other)
      (index == other.index) && (elements == other.elements) if other.respond_to?(:index) && other.respond_to?(:elements)
    end
  end
end
