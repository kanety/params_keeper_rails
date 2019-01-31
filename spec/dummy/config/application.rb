require_relative 'boot'

# Pick the frameworks you want:
require 'action_controller/railtie'
require 'action_view/railtie'
require 'active_model/railtie'

Bundler.require(*Rails.groups)
require "params_keeper_rails"

module Dummy
  class Application < Rails::Application
    config.secret_key_base = 'key'
  end
end
