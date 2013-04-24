require 'spec_helper'


describe SimplyPaginate::Paginator do
  before do
    SimplyPaginate::Paginator.per_page = 3
    @paginator = SimplyPaginate::Paginator.new [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  end

  describe 'before paginating' do
    it 'must be able to paginate' do
      @paginator.total_pages.must_equal 4
    end
  end

  describe 'after paginating' do
    before do
      SimplyPaginate::Paginator.per_page = 5

      @first_page = SimplyPaginate::Page.new(0, 4, @paginator)
      @last_page = SimplyPaginate::Page.new(5, 9, @paginator)

      @pages = [@first_page, @last_page]
    end

    it 'must be able to paginate' do
      @paginator.total_pages.must_equal 2
    end

    it 'must be able to retrieve a certain page' do
      @paginator[0].elements.must_equal @first_page.elements
      @paginator[0].previous.must_be_nil
      @paginator[0].next.wont_be_nil
    end

    it 'must be able to retrieve all pages' do
      @paginator.total_pages.must_equal 2

      #test first element
      @paginator[0].elements.must_equal @first_page.elements
      @paginator[0].previous.must_be_nil
      @paginator[0].next.wont_be_nil

      #test second element
      @paginator[1].elements.must_equal @last_page.elements
      @paginator[1].previous.wont_be_nil
      @paginator[1].next.must_be_nil
    end
  end
end
