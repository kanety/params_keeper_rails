class SamplesController < ApplicationController
  include ParamsKeeper::Controller
  keep_params :key

  def index
    @url_for_hash = url_for(action: :index)
    @url_for_string = url_for("http://www.example.com/samples")
    @url_for_model = url_for(Sample.new(1))
  end
end
