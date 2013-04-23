require 'spec_helper'

describe SimplyPaginate::Paginator do
  before do
    @paginator = SimplyPaginate::Paginator.new [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  end

  describe 'before paginating' do
    it 'must be able to paginate' do
      @paginator.paginate(3).pages.count.must_equal 4
    end

    it 'must not be able to retrieve a certain page' do
      @paginator[0].must_be_nil
    end

    it 'must not be able to retrieve all pages' do
      @paginator.pages.must_equal []
    end
  end

  describe 'after paginating' do
    before do
      @paginator.paginate(5)

      @first_page = SimplyPaginate::Page.new(0, 4, @paginator)
      @last_page = SimplyPaginate::Page.new(5, 9, @paginator, @first_page, nil)
      @first_page.next = @last_page

      @pages = [@first_page, @last_page]
    end

    it 'must be able to paginate' do
      @paginator.paginate(3).pages.count.must_equal 4
    end

    it 'must be able to retrieve a certain page' do
      @paginator[0].elements.must_equal @first_page.elements
      @paginator[0].previous.must_be_nil
      @paginator[0].next.wont_be_nil
    end

    it 'must be able to retrieve all pages' do
      @paginator.pages.count 2

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
