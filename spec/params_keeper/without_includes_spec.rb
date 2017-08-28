class WithoutIncludesController < ActionController::Base
  def index
    @url = url_for(action: :index)
    render inline: <<-ERB
      link = <%= link_to '', action: :index %>
    ERB
  end
end

describe WithoutIncludesController, type: :controller do
  context 'without inclusion of params_keeper' do
    it 'is not affected' do
      get :index, params: { test: 'VALUE' }
      expect(assigns(:url)).to eq('/without_includes')
      expect(response.body).to include('link = <a href="/without_includes"></a>')
    end
  end
end
