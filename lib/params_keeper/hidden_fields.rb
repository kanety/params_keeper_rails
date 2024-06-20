# frozen_string_literal: true

module ParamsKeeper
  class HiddenFields
    def initialize(controller, url_options)
      @controller = controller
      @url_options = url_options
    end

    def call
      return if @controller.class.keep_params_configs.blank?

      params = ParamsKeeper::Resolver.new(@controller, @url_options).call
      return if params.blank?

      CGI.parse(params.to_query).flat_map do |key, values|
        values.map { |value| @controller.view_context.hidden_field_tag(key, value, id: nil) }
      end.join.html_safe
    end
  end
end
