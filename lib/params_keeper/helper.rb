module ParamsKeeper::Helper
  def url_for(options = nil)
    if controller
      ParamsKeeper::Resolver.new(self, controller, options).resolve || super
    else
      super
    end
  end

  def form_with(**options, &block)
    if controller && options[:method].to_s.downcase == 'get'
      html = super
      url_options = options[:model] || options[:url]
      if ParamsKeeper::Resolver.new(self, controller, url_options).target?
        html.sub('</form>') { "#{hidden_fields_for_keep_params}</form>" }.html_safe
      else
        html
      end
    else
      super
    end
  end

  def hidden_fields_for_keep_params
    target_params = params.respond_to?(:to_unsafe_h) ? params.to_unsafe_h : params
    target_params = target_params.slice(*controller.keep_params_config[:keys])
    return if target_params.blank?

    CGI.parse(target_params.to_query).flat_map do |key, values|
      values.map { |value| hidden_field_tag(key, value, id: nil) }
    end.join.html_safe
  end
end
