module ParamsKeeper::Controller
  extend ActiveSupport::Concern

  included do
    class_attribute :keep_params_config
    helper ParamsKeeper::Helper
  end

  def url_for(options = nil)
    ParamsKeeper::Resolver.new(self, self, options).resolve || super
  end

  class_methods do
    def keep_params(*args)
      self.keep_params_config = {
        keys: nil,
        to: nil,
        for: :hash,
        url_options: nil
      }
      self.keep_params_config.merge!(args.last.is_a?(Hash) ? args.pop : {})
      self.keep_params_config[:keys] = Array(args)
    end
  end
end
