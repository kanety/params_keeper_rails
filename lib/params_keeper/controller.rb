require 'params_keeper/helper'

module ParamsKeeper::Controller
  extend ActiveSupport::Concern

  included do
    class_attribute :keep_params_keys, :keep_params_configs
    helper ParamsKeeper::Helper
  end

  def url_for(options = nil)
    return super if options.is_a?(Hash) && options.delete(:keep_params) == false

    configs = self.class.keep_params_configs
    keys = self.class.keep_params_keys
    return super if keys.blank?

    if configs.key?(:only) || configs.key?(:except)
      types = (Array(configs[:only]).presence || [:hash, :string, :model]) - Array(configs[:except])
      return super if (options.is_a?(Hash) && !types.include?(:hash)) ||
                      (options.is_a?(String) && !types.include?(:string)) ||
                      (options.class.respond_to?(:model_name) && !types.include?(:model))
    end

    if options.is_a?(Hash)
      if keep_params?(options, configs)
        super(ParamsKeeper::Helper.merge_params(options, params, keys))
      else
        super
      end
    else
      url = super(options)
      url_opts = begin
                   Rails.application.routes.recognize_path(url)
                 rescue ActionController::RoutingError
                   nil
                 end
      if url_opts && keep_params?(url_opts, configs)
        super(ParamsKeeper::Helper.merge_params(url_opts, params, keys))
      else
        url
      end
    end
  end

  def keep_params?(options, configs)
    controller = options[:controller].to_s
    if configs[:to]
      target = [controller, controller_name, controller_path]
      Array(configs[:to]).any? { |c| c.to_s.in?(target) }
    else
      controller.blank? || controller.in?([controller_name, controller_path])
    end
  end

  class_methods do
    def keep_params(*args)
      self.keep_params_configs = args.last.is_a?(Hash) ? args.pop : {}
      self.keep_params_keys = Array(args)
    end
  end
end
