require 'spec_helper'

include SimplyPaginate

describe Page do
  include Helpers

  let(:first_page) { build_page 1 }

  let(:second_page) { build_page 2 }

  let(:last_page) { build_page 4 }

  it "must represent a specific page on a collection" do
    first_page.elements.must_equal [1, 2, 3]
    first_page.index.must_equal SimplyPaginate::FIRST_PAGE_INDEX
  end

  it "must be able to retrieve it's elements" do
    first_page.elements.must_equal [1, 2, 3]
  end

  it "must be able to compare with other page" do
    first_page.must_equal first_page
    first_page.wont_equal second_page
    first_page.wont_equal Page.new(1, page_array_collection, 5)
    first_page.must_equal Page.new(1, [1, 2, 3], 3)
  end

  it "must be able to move forward" do
    first_page.next.must_equal second_page
    last_page.next.must_be_nil
  end

  it "must be able to move backwards" do
    first_page.previous.must_be_nil
    second_page.previous.must_equal first_page
  end
end
