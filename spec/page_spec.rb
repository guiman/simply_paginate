require 'spec_helper'

describe SimplyPaginate::Page do
  before do
    SimplyPaginate::Paginator.per_page = 5

    @paginator = SimplyPaginate::Paginator.new([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
    @first_page = SimplyPaginate::Page.new(0, 4, @paginator)
    @last_page = SimplyPaginate::Page.new(5, 9, @paginator)

    class SimplyPaginate::Page
      def paginator
        @paginator
      end
    end
  end

  it "must always have an instance of paginator" do
    @first_page.paginator.wont_be_nil
    @last_page.paginator.wont_be_nil

    @first_page.next.paginator.wont_be_nil
    @first_page.next.previous.paginator.wont_be_nil
  end

  it "must be able to get the elements" do
    @first_page.elements.must_equal [1, 2, 3, 4, 5]
    @last_page.elements.must_equal [6, 7, 8, 9, 10]

    @first_page.next.elements.must_equal [6, 7, 8, 9, 10]
    @last_page.previous.elements.must_equal [1, 2, 3, 4, 5]
  end

  describe "when having next and previous pages" do
    before do
      SimplyPaginate::Paginator.per_page = 2
    end

    it "must be able to go back and foward" do
      @paginator[1].next.elements.must_equal @paginator[2].elements
      @paginator[1].previous.elements.must_equal @paginator[0].elements
    end
  end

  describe "when having previous and no next" do
    it "must be able to go back " do
      @last_page.next.must_be_nil
      @last_page.previous.elements.must_equal @first_page.elements
    end
  end

  describe "when having next and no previous" do
    it "must be able to go back " do
      @first_page.next.elements.must_equal @last_page.elements
      @first_page.previous.must_be_nil
    end
  end

end
