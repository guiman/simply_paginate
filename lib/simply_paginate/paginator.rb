module SimplyPaginate
  class Paginator
    attr_reader :collection
    attr_accessor :current

    def self.per_page=(amount_per_page)
      raise NotInRangeError.new("Amount per page should be greater than 0") unless amount_per_page > 0

      @@per_page = amount_per_page
    end

    def self.per_page
      @@per_page
    end

    def initialize(collection)
      @collection = collection
      @current = nil
    end

    def [](pos)
      first = pos * @@per_page
      last = first + @@per_page - 1

      ((first < 0) || (first >= self.collection.count)) ? nil : Page.new(first, last, self)
    end

    def total_pages
      (@collection.count.to_f / @@per_page.to_f).ceil
    end

    Paginator.per_page = 10
  end
end
