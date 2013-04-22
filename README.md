# SimplyPaginate

Simply paginate will do just that, give me a collection and you will be able to use a pagination logic (no extra html boilerplate or dependecies).

## Installation

Add this line to your application's Gemfile:

    gem 'simply_paginate'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simply_paginate

## Motivation
When dealing with pagination most known gems come bundled with lots of extra functionality I usually don't need (like html boilerplate), this is my attempt to create just the pagination logic, as simple as that.

## Usage

```ruby
require 'simply_paginate'

collection = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

paginator = SimplyPaginate::Paginator.new(collection)

# create pages with max of 3 elements
paginator.paginate 3

# retrieve a certain page
paginator[0]

#move through the pages freely
paginator[0].next
paginator[0].previous

#you might want the first element on the 2nd page
paginator[0].next.next.next.previous[0]

#or maybe all of them
paginator[0].next.next.next.previous.elements
```

## Currently working on:

* Moving from a copy algorithm to a more performant pagination using offsets.
* Adding support for common ORMs like: ActiveRecord, Sequel and DataMapper.
* Testing...

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
