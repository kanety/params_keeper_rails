require_relative 'boot'

# Pick the frameworks you want:
require 'action_controller/railtie'
require 'action_view/railtie'
require 'active_model/railtie'

Bundler.require(*Rails.groups)
require "params_keeper_rails"

module Dummy
  class Application < Rails::Application
    config.load_defaults Rails::VERSION::STRING.to_f if config.respond_to?(:load_defaults)

    config.secret_key_base = 'key'
  end
end
