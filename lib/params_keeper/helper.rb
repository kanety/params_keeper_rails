module ParamsKeeper
  module Helper
    def url_for(url_options = nil)
      return super unless controller

      ParamsKeeper::UrlFor.new(self, controller, url_options).call || super
    end

    def form_with(**options, &block)
      return super unless controller
      return super if options[:method].to_s.downcase != 'get'

      html = super
      url_options = options[:url] || options[:model]
      hidden_fields = ParamsKeeper::HiddenFields.new(controller, url_options).call
      if hidden_fields.present?
        html.sub(/^(<form[^>]*>)/) { "#{$1}#{hidden_fields}" }.html_safe
      else
        html
      end
    end
  end
end
