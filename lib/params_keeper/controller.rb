module ParamsKeeper::Controller
  extend ActiveSupport::Concern

  included do
    class_attribute :keep_params_configs
    helper ParamsKeeper::Helper
  end

  def url_for(options = nil)
    ParamsKeeper::UrlFor.new(self, self, options).call || super
  end

  def redirect_to(options = {}, response_options = {})
    if options.is_a?(String)
      url = ParamsKeeper::UrlFor.new(self, self, options).call
      url ?super(url, response_options) : super
    else
      super
    end
  end

  class_methods do
    def keep_params(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      config = ParamsKeeper::Config.new(args, options)
      self.keep_params_configs = keep_params_configs.to_a + [config]
    end

    def clear_keep_params!
      self.keep_params_configs = nil
    end
  end
end
