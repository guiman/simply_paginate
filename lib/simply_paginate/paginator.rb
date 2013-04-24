module SimplyPaginate
  class Paginator
    attr_reader :pages, :collection

    def self.per_page=(pages_per_page)
      @@per_page = pages_per_page
    end

    def self.per_page
      @@per_page
    end

    def initialize(collection)
      @collection = collection
      @pages = []
      @current = nil
    end

    def [](pos)
      first = pos * @@per_page
      last = first + @@per_page - 1

      Page.new(first, last, self)
    end

    def total_pages
      (@collection.count.to_f / @@per_page.to_f).ceil
    end

    def current=(page)
      @current = page
    end

    Paginator.per_page = 10
  end
end
