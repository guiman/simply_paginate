# SimplyPaginate
[![Build Status](https://travis-ci.org/guiman/simply_paginate.png)](https://travis-ci.org/guiman/simply_paginate) [![Code Climate](https://codeclimate.com/github/guiman/simply_paginate.png)](https://codeclimate.com/github/guiman/simply_paginate)

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

include SimplyPaginate

collection = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

pages = Paginator.new(collection, 3)

# retrieve a certain page
pages[1]

#move through the pages freely
pages[1].next
pages[1].previous

#you might want the first element on the 3rd page
pages[1].next.next.next.previous.elements[0]

#or maybe all of them
pages[0].next.next.next.previous.elements

#you can also iterate the ruby way
pages.each do |page|
  puts page.elements
end

#or in a more old fashion way
pages.start

while pages.next? do
  puts pages.current.elements
  
  pages.next!
end
```

## Changes on this branch
Well this branch introduced a better design about the relationship between pages and page, and also
an improvement on the API.

Now a Page can be used without the need of having a Paginator, and also a Paginator could be transversed
without need to access pages directly.

```ruby
require 'simply_paginate'

include SimplyPaginate

collection = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# Give me the first page of the collection with a size of 3
first_page = Page.new(1, collection, 3)

first_page.elements
#=> [1, 2, 3]
first_page.next.elements
#=> [4, 5, 6]
```

##0.0.4 - Features:

* Redesign on relation between paginator and pages. You can use them togheter or separately.
* Improved API for Paginator, now including:
  * each iteration
  * next!, next?, current and start methods for manual iteration
  * first and last accessors
* Test improvement
 
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
