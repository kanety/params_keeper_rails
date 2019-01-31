# ParamsKeeperRails

A rails controller extension for keeping specific parameters through links.

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

# hash
url_for(action: :show)  #=> '/examples/:id?key1=**&key2=**'

# string and active model don't keep parameters by defalut
url_for('/examples')  #=> '/examples'
url_for(@example)  #=> '/examples/:id'

# parameters are not kept if destination controller is different from current controller
url_for(controller: 'examples2', action: :index)  #=> '/examples2'

# parameters are not kept if you set keep_params: false
url_for(action: :show, keep_params: false)  #=> '/examples/:id'
```

Enable only specific class of url_for:

```ruby
# enable only hash like url_for(action: :show)
keep_params :key1, :key2, for: :hash

# enable only string like url_for('/examples')
keep_params :key1, :key2, for: :string

# enable only model like url_for(@example)
keep_params :key1, :key2, for: :model
```

Specify default options of url_for:

```ruby
keep_params :key1, :key2, url_options: { fixed_param: :something }
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

Bug reports and pull requests are welcome on GitHub at https://github.com/kanety/params_keeper_rails.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

