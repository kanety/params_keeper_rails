module ParamsKeeper::Helper
  def url_for(options = nil)
    if controller
      ParamsKeeper::Resolver.new(self, controller, options).resolve || super
    else
      super
    end
  end
end
