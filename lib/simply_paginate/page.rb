module SimplyPaginate
  class Page
    attr_reader :next_page, :previous_page

    def initialize(first, last, paginator, previous_page = nil, next_page = nil)
      @first = first
      @last = last
      @paginator = paginator
      @next_page = next_page
      @previous_page = previous_page
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
      @paginator.collection[@first..@last]
    end
  end
end
