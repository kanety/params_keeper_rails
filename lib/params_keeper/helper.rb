module ParamsKeeper::Helper
  def url_for(options = nil)
    ParamsKeeper::Resolver.new(self, controller, options).resolve || super
  end
end
