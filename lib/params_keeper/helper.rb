module ParamsKeeper::Helper
  def url_for(options = nil)
    controller.url_for(options)
  end

  class << self
    def merge_params(options, params, keep_params_keys)
      keeps = params.to_unsafe_h.deep_symbolize_keys.slice(*keep_params_keys.to_a)
      options.reverse_merge(keeps)
    end
  end
end
