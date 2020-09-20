class ParamsKeeper::UrlFor
  def initialize(caller, controller, url_options)
    @caller = caller
    @controller = controller
    @url_options = url_options
  end

  def call
    return if @controller.class.keep_params_configs.blank?

    resolver = ParamsKeeper::Resolver.new(@controller, @url_options)
    params = resolver.call

    if params.present?
      base_url_for(resolver.url_options_hash.reverse_merge(params))
    else
      base_url_for(@url_options)
    end
  end

  private

  def base_url_for(url_options)
    @caller.method(:url_for).super_method.call(url_options)
  end
end
