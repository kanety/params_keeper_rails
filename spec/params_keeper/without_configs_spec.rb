class WithoutConfigsController < ActionController::Base
  include ParamsKeeper::Controller

  def index
    @url = url_for(action: :index)
    render inline: <<-ERB
      link = <%= link_to '', action: :index %>
    ERB
  end
end

describe WithoutConfigsController, type: :controller do
  context 'include params_keeper without config' do
    it 'is not affected' do
      get :index, params: { test: 'VALUE' }
      expect(assigns(:url)).to eq('/without_configs')
      expect(response.body).to include('link = <a href="/without_configs"></a>')
    end
  end
end
