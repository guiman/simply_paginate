require 'spec_helper'

Paginator.per_page = 3

describe Paginator do
  include Helpers

  let(:pages) { Paginator.new page_array_collection }

  let(:first_page) { build_page 1 }

  let(:last_page) { build_page 4 }

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

  it "must be able to retrieve the first page" do
    pages.first.must_equal first_page
  end

  it "must be able to retrieve the last page" do
    pages.last.must_equal pages[4]
  end

  describe "when creating a paginator with an instance per_page", :focus do
    it "must remember the per_page setting" do
      pages = Paginator.new(page_array_collection, 2)
      pages.first.elements.size.must_equal 2
    end
  end

  describe "when iterating using 'start', 'next!' and 'next?'" do
    it "must need to start before moving to the next " do
      lambda { pages.next! }.must_raise NoMethodError
    end

    it "must move to the next page using 'next!'" do
      iteration_pages = pages
      iteration_pages.start
      iteration_pages.next!
      iteration_pages.current.must_equal build_page(2)
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
