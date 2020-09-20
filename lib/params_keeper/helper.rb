module ParamsKeeper::Helper
  def url_for(url_options = nil)
    if controller
      ParamsKeeper::UrlFor.new(self, controller, url_options).call || super
    else
      super
    end
  end

  def form_with(**options, &block)
    if controller && options[:method].to_s.downcase == 'get'
      html = super
      hidden_fields = ParamsKeeper::HiddenFields.new(controller, options[:model] || options[:url]).call
      if hidden_fields.present?
        html.sub('</form>') { "#{hidden_fields}</form>" }.html_safe
      else
        html
      end
    else
      super
    end
  end
end
