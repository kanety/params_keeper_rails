class ParamsKeeper::Resolver
  def initialize(klass, controller, options)
    @klass = klass
    @controller = controller
    @options = options
  end

  def resolve
    return if !configured? || !enable_options? || !target_options?

    if @options.is_a?(Hash)
      resolve_from_hash
    else
      resolve_from_routing
    end
  end

  private

  def resolve_from_hash
    if link_to_target_controller?(@options)
      base_url_for(self.class.merge_params(@options, @controller.params, config[:keys]))
    else
      base_url_for(@options)
    end
  end

  def resolve_from_routing
    url = base_url_for(@options)
    url_opts = recognize_path(url)

    if url_opts && link_to_target_controller?(url_opts)
      base_url_for(self.class.merge_params(url_opts, @controller.params, config[:keys]))
    else
      url
    end
  end

  def link_to_target_controller?(options)
    controller = options[:controller].to_s
    if config[:to].present?
      ([controller] - Array(config[:to])).blank?
    else
      controller.blank? || controller.in?([@controller.controller_name, @controller.controller_path])
    end
  end

  def config
    @controller.class.keep_params_config
  end

  def configured?
    config && config[:keys].present?
  end

  def enable_options?
    !@options.is_a?(Hash) || @options.delete(:keep_params) != false
  end

  def target_options?
    fors = Array(config[:for] || :hash)
    (fors.include?(:hash) && @options.is_a?(Hash)) ||
      (fors.include?(:string) && @options.is_a?(String)) ||
      (fors.include?(:model) && @options.class.respond_to?(:model_name))
  end

  def recognize_path(url)
    Rails.application.routes.recognize_path(url)
  rescue ActionController::RoutingError
    nil
  end

  def base_url_for(options)
    options = options.merge(config[:url_options]) if options.is_a?(Hash) && config[:url_options]
    @klass.method(:url_for).super_method.call(options)
  end

  class << self
    def merge_params(options, params, keys)
      keeps = params.to_unsafe_h.deep_symbolize_keys.slice(*keys.to_a)
      options.reverse_merge(keeps)
    end
  end
end
