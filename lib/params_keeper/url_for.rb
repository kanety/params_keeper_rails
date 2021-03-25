module ParamsKeeper
  class UrlFor
    def initialize(caller, controller, url_options)
      @caller = caller
      @controller = controller
      @url_options = url_options
    end

    def call
      return if @controller.class.keep_params_configs.blank?

      params = ParamsKeeper::Resolver.new(@controller, @url_options).call
      return if params.blank?

      base_url_for(params)
    end

    private

    def base_url_for(url_options)
      @caller.method(:url_for).super_method.call(url_options)
    end
  end
end
