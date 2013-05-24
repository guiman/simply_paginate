require 'spec_helper'

Paginator.per_page = 3

describe Paginator do

  let(:page_array_collection) { [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] }

  let(:pages) { Paginator.new page_array_collection }

  let(:page) { lambda { |number| Page.new number, page_array_collection } }

  let(:first_page) { page.call(1) }

  let(:last_page) { page.call(4) }

  it "must be able to iterate using each" do
    count = 0
    results = []

    pages.each do |page|
      page.wont_be_nil
      results << page.elements

      count += 1
    end

    count.must_equal 4
    results.must_equal [[1,2,3], [4,5,6], [7,8,9], [10]]
  end

  it "must be able to tell how many pages there are" do
    pages.total_pages.must_equal 4
  end

  it "must be able to retrieve a certain page" do
    pages[0].must_be_nil
    pages[1].wont_be_nil
    pages[1].must_equal first_page
    pages[4].must_equal last_page
    pages[5].must_be_nil
  end

  describe "when iterating using 'start', 'next' and 'next?'" do
    it "must need to start before moving to the next " do
      ->{  pages.next! }.must_raise NoMethodError
    end

    it "must move to the next page using 'next'" do
      iteration_pages = pages
      iteration_pages.start
      iteration_pages.next!
      iteration_pages.current.must_equal Page.new(2, page_array_collection)
    end

    it "must retrieve the current page using 'current'" do
      iteration_pages = pages
      iteration_pages.current.must_be_nil
      iteration_pages.start
      iteration_pages.current.must_equal first_page
    end

    it "must retrieve if we can get a next value using 'next?'" do
      iteration_pages = pages
      iteration_pages.next?.must_equal false
      iteration_pages.start
      iteration_pages.next?.must_equal true
      4.times { iteration_pages.next! }
      iteration_pages.next?.must_equal false
    end
  end
end
