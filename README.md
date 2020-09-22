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

Parameters are kept via `url_for` if destination controller is same as current controller.
For example:

```ruby
GET "/examples?key1=**&key2=**"

# hash arg
url_for(action: :index)  #=> '/examples?key1=**&key2=**'

# parameters are not kept if string or model arg is specified
url_for('/examples')  #=> '/examples'
url_for(@example)  #=> '/examples/:id'

# parameters are not kept if destination controller is different from current controller
url_for(controller: 'examples2', action: :index)  #=> '/examples2'

# parameters are not kept if you put "keep_params: false" into args
url_for(action: :show, keep_params: false)  #=> '/examples/:id'
```

Parameters are kept for form with GET method via hidden fields.
This feature is supported by `form_with` for rails >= 5.1.

```ruby
<%= form_with url: { action: :index}, method: :get do %>
  <%= submit_tag 'submit' %>
<% end %>
#=> ...<input type="hidden" name="key1" value="**" />
#      <input type="hidden" name="key2" value="**" /></form>
```

## Options

### Argument type

Enable only specific argument type of url_for:

```ruby
# hash arg (same as default behaviour)
keep_params :key1, :key2, for: :hash
url_for(action: :index)  #=> '/examples?key1=**&key2=**'

# string arg
keep_params :key1, :key2, for: :string
url_for('/examples')  #=> '/examples?key1=**&key2=**'

# model arg
keep_params :key1, :key2, for: :model
url_for(@example)  #=> '/examples/:id?key1=**&key2=**'
```

`:for` allows to set multiple argument type as follows:

```ruby
keep_params :key1, :key2, for: [:hash, :model]
```

### Multiple controllers

Keep parameters throught multiple controllers:

```ruby
class ExamplesController < ApplicationController
  include ParamsKeeper::Controller
  keep_params :key1, :key2, to: %w(examples examples2)
end

class Examples2Controller < ApplicationController
  include ParamsKeeper::Controller
  keep_params :key1, :key2, to: %w(examples examples2)
end
```

### Default parameters

Specify default parameters:

```ruby
keep_params :key1, :key2, url_options: { fixed_param: :something }
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kanety/params_keeper_rails.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

