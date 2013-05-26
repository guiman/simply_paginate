require 'bundler'
require 'minitest/autorun'
Bundler.require

module Helpers
  def page_array_collection
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  end

  def build_page(number)
    lambda { Page.new number, page_array_collection, 3 }.call
  end
end
