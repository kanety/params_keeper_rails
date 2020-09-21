module ParamsKeeper
  class Config
    attr_accessor :keys, :to, :for, :url_options

    def initialize(keys, options = {})
      @keys = Array(keys)
      @to = Array(options[:to])
      @for = Array(options[:for] || :hash)
      @url_options = options[:url_options] || {}
    end
  end
end
