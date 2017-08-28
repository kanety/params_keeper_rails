require 'rails'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'active_model/railtie'
require 'rspec/rails'
require 'rails-controller-testing'

module Dummy
  class Application < Rails::Application
    config.eager_load = false
    config.secret_key_base = 'key'
    config.action_controller.default_url_options = { only_path: true }
  end
end

Rails.application = Dummy::Application
Rails.application.initialize!
Rails.application.routes.draw do
  resources :samples do
    collection do
      get :test_url_for
      3.times do |i|
        get "test_config_only#{i+1}"
        get "test_config_except#{i+1}"
      end
      2.times do |i|
        get "test_config_to#{i+1}"
      end
      get :test_keep_params
      get :test_redirect_to
    end
  end
  resources :others1
  resources :others2
  resources :without_configs
  resources :without_includes
end
