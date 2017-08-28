# ParamsKeeperRails

A rails gem for keeping specific parameters through links.

## Dependencies

* ruby 2.3+
* rails 5.0+

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'params_keeper_rails'
```

And then execute:

    $ bundle

## Usage

Include modules in your controller and specify parameter keys you want to keep:

```ruby
class ExamplesController < ApplicationController
  include ParamsKeeper::Controller
  keep_params :key1, :key2
```

Parameters are kept if destination controller is same as current controller.
For example:

```ruby
GET "/examples?key1=**&key2=**"

# hash argument
url_for(action: :show)  #=> '/examples/:id?key1=**&key2=**'

# string argument
url_for('/examples')  #=> '/examples?key1=**&key2=**'

# active model argument
url_for(@example)  #=> '/examples/:id?key1=**&key2=**'

# parameters are not kept if destination controller is different from current controller
url_for(controller: 'examples2', action: :index)  #=> '/examples2'

# parameters are not kept with keep_params: false
url_for(action: :show, keep_params: false)  #=> '/examples/:id'
```

Enable specific class of argument:

```ruby
keep_params :key1, :key2, only: :hash    # only hash argument like url_for(action: :show) keeps parameters
keep_params :key1, :key2, only: :string  # only string argument like url_for('/examples') keeps parameters
keep_params :key1, :key2, only: :model   # only model argument like url_for(@example) keeps parameters
```

Keep parameters throught multiple controllers:

```ruby
class ExamplesController < ApplicationController
  include ParamsKeeper::Controller
  keep_params :key1, :key2, to: %w(examples nested_examples)
end

class NestedExamplesController < ApplicationController
  include ParamsKeeper::Controller
  keep_params :key1, :key2, to: %w(examples nested_examples)
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kanety/params_keeper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

