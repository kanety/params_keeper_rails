class NormalsController < ActionController::Base
  def index
    @url = url_for(action: :index)
  end
end
