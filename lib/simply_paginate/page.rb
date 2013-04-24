module SimplyPaginate
  class Page
    attr_reader :next_page, :previous_page

    def initialize(first, last, paginator, previous_page = nil, next_page = nil)
      @first = first
      @last = last
      @paginator = paginator
    end

    def next
      first = @last + 1
      last = first + Paginator.per_page - 1

      (first >= @paginator.collection.count) ? nil : @paginator.current = Page.new(first, last, @paginator)
    end

    def previous
      first = @first - Paginator.per_page
      last = @first - 1

      (first < 0) ? nil : @paginator.current = Page.new(first, last, @paginator)
    end

    def elements
      @paginator.collection[@first..@last]
    end
  end
end
