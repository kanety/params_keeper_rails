# frozen_string_literal: true

module ParamsKeeper
  class Resolver
    def initialize(controller, url_options)
      @controller = controller
      @url_options = url_options
      @cache = {}
    end

    def call
      return {} if configs.blank? || skip_url_options?

      configs.each_with_object({}) do |config, params|
        if target_config?(config)
          params.merge!(extract_params(config))
        end
      end
    end

    def url_options_hash
      if @url_options.is_a?(Hash)
        @url_options
      else
        recognize_path(base_url_for(@url_options))
      end
    end

    private

    def configs
      @controller.class.keep_params_configs
    end

    def skip_url_options?
      if @url_options.is_a?(Hash)
        @url_options.delete(:keep_params) == false
      else
        false
      end
    end

    def target_config?(config)
      target_url_options?(config) && target_controller?(config)
    end

    def target_url_options?(config)
      (config.for.include?(:hash) && @url_options.is_a?(Hash)) ||
        (config.for.include?(:string) && @url_options.is_a?(String)) ||
        (config.for.include?(:model) && @url_options.class.respond_to?(:model_name))
    end

    def target_controller?(config)
      dests = destination_controllers(url_options_hash)
      if config.to.present?
        (dests & config.to.map(&:to_s)).present?
      else
        (dests & current_controllers).present?
      end
    end

    def destination_controllers(url_options_hash)
      if url_options_hash[:controller].present?
        [url_options_hash[:controller].to_s]
      else
        current_controllers
      end
    end

    def current_controllers
      [@controller.controller_name, @controller.controller_path]
    end

    def recognize_path(url)
      @cache[url] ||= Rails.application.routes.recognize_path(url)
    rescue ActionController::RoutingError
      {}
    end

    def extract_params(config)
      params = @controller.request.params.deep_symbolize_keys
      params.slice(*config.keys).merge(config.url_options)
    end

    def base_url_for(url_options)
      @controller.method(:url_for).super_method.call(url_options)
    end
  end
end
