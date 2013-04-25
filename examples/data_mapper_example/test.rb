require 'bundler'
Bundler.require

DataMapper.setup :default, 'sqlite::memory:'

class Person
  include DataMapper::Resource

  property :id, Serial
  property :age, String
end

DataMapper.auto_migrate!

100.times { Person.create age: rand(1..90) }

paginator = SimplyPaginate::Paginator.new(Person.all)

paginator[0].elements.all(:age.gt => 10)
