module SimplyPaginate
  FIRST_PAGE_INDEX = 1

  class Paginator
    attr_reader :collection

    def self.per_page=(amount_per_page)
      raise NotInRangeError.new("Amount per page should be greater than 0") unless amount_per_page > 0

      @@per_page = amount_per_page
    end

    def self.per_page
      @@per_page
    end

    def initialize(collection, per_page = self.class.per_page)
      @collection = collection
      @per_page = per_page
    end

    ## Basic Operations

    def first
      self[FIRST_PAGE_INDEX]
    end

    def last
      self[total_pages]
    end

    def total_pages
      (@collection.count / @per_page) + (@collection.count % @per_pages)
    end

    def [](index)
      Page.new(index, @collection, @per_page) unless collection.empty? || index <= 0 || index > total_pages
    end

    ## Iteration

    def next!
      raise NoMethodError.new("You need to start before iterating") unless current
      @current = current.next
    end

    def next?
      current != nil
    end

    def start
      @current = first
    end

    def current
      @current
    end

    def each
      start

      while next? do
        yield current

        next!
      end
    end

    Paginator.per_page = 10
  end
end
