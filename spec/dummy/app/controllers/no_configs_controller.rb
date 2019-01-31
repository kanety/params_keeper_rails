class NoConfigsController < ActionController::Base
  include ParamsKeeper::Controller

  def index
    @url = url_for(action: :index)
  end
end
