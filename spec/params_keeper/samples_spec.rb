class Sample
  include ActiveModel::Model
  attr_accessor :id

  def initialize(id)
    self.id = id
  end
end

class SamplesController < ActionController::Base
  include ParamsKeeper::Controller

  def common
    @url_hash = url_for(action: :index)
    @url_string = url_for("/samples")
    @url_model = url_for(Sample.new(1))
    render inline: <<-ERB
      link_to_hash = <%= link_to '', action: :index %>
      link_to_string = <%= link_to '', "/samples" %>
      link_to_model = <%= link_to '', Sample.new(1) %>
    ERB
  end

  def test_url_for
    self.class.keep_params :test
    common
  end

  def test_config_only1
    self.class.keep_params :test, only: :hash
    common
  end

  def test_config_only2
    self.class.keep_params :test, only: :string
    common
  end

  def test_config_only3
    self.class.keep_params :test, only: :model
    common
  end

  def test_config_except1
    self.class.keep_params :test, except: :hash
    common
  end

  def test_config_except2
    self.class.keep_params :test, except: :string
    common
  end

  def test_config_except3
    self.class.keep_params :test, except: :model
    common
  end

  def config_to_common
    @url_samples1 = url_for(action: :index)
    @url_samples2 = url_for(controller: :samples, action: :index)
    @url_others1 = url_for(controller: :others1, action: :index)
    @url_others2 = url_for(controller: :others2, action: :index)
    render plain: ''
  end

  def test_config_to1
    self.class.keep_params :test
    config_to_common
  end

  def test_config_to2
    self.class.keep_params :test, to: %w(others1)
    config_to_common
  end

  def test_redirect_to
    self.class.keep_params :test
    redirect_to action: :index
  end

  def test_keep_params
    self.class.keep_params :test
    @url_hash = url_for(action: :index, keep_params: false)
    render plain: ''
  end
end

describe SamplesController, type: :controller do
  context 'with url_for and link_to' do
    it 'recognizes argument types' do
      get :test_url_for, params: { test: 'VALUE' }
      expect(assigns(:url_hash)).to eq('/samples?test=VALUE')
      expect(assigns(:url_string)).to eq('/samples?test=VALUE')
      expect(assigns(:url_model)).to eq('/samples?test=VALUE')
      expect(response.body).to include('link_to_hash = <a href="/samples?test=VALUE"></a>')
      expect(response.body).to include('link_to_string = <a href="/samples?test=VALUE"></a>')
      expect(response.body).to include('link_to_model = <a href="/samples?test=VALUE"></a>')
    end
  end

  context 'with :only config' do
    it 'recognizes hash' do
      get :test_config_only1, params: { test: 'VALUE' }
      expect(assigns(:url_hash)).to eq('/samples?test=VALUE')
      expect(assigns(:url_string)).to eq('/samples')
      expect(assigns(:url_model)).to eq('/samples')
    end

    it 'recognizes string' do
      get :test_config_only2, params: { test: 'VALUE' }
      expect(assigns(:url_hash)).to eq('/samples')
      expect(assigns(:url_string)).to eq('/samples?test=VALUE')
      expect(assigns(:url_model)).to eq('/samples')
    end

    it 'recognizes model' do
      get :test_config_only3, params: { test: 'VALUE' }
      expect(assigns(:url_hash)).to eq('/samples')
      expect(assigns(:url_string)).to eq('/samples')
      expect(assigns(:url_model)).to eq('/samples?test=VALUE')
    end
  end

  context 'with :except config' do
    it 'recognizes hash' do
      get :test_config_except1, params: { test: 'VALUE' }
      expect(assigns(:url_hash)).to eq('/samples')
      expect(assigns(:url_string)).to eq('/samples?test=VALUE')
      expect(assigns(:url_model)).to eq('/samples?test=VALUE')
    end

    it 'recognizes string' do
      get :test_config_except2, params: { test: 'VALUE' }
      expect(assigns(:url_hash)).to eq('/samples?test=VALUE')
      expect(assigns(:url_string)).to eq('/samples')
      expect(assigns(:url_model)).to eq('/samples?test=VALUE')
    end

    it 'recognizes model' do
      get :test_config_except3, params: { test: 'VALUE' }
      expect(assigns(:url_hash)).to eq('/samples?test=VALUE')
      expect(assigns(:url_string)).to eq('/samples?test=VALUE')
      expect(assigns(:url_model)).to eq('/samples')
    end
  end

  context 'without :to config' do
    it 'recognizes controller' do
      get :test_config_to1, params: { test: 'VALUE' }
      expect(assigns(:url_samples1)).to eq('/samples?test=VALUE')
      expect(assigns(:url_samples2)).to eq('/samples?test=VALUE')
      expect(assigns(:url_others1)).to eq('/others1')
      expect(assigns(:url_others2)).to eq('/others2')
    end
  end

  context 'with :to config' do
    it 'recognizes controller' do
      get :test_config_to2, params: { test: 'VALUE' }
      expect(assigns(:url_samples1)).to eq('/samples')
      expect(assigns(:url_samples2)).to eq('/samples')
      expect(assigns(:url_others1)).to eq('/others1?test=VALUE')
      expect(assigns(:url_others2)).to eq('/others2')
    end
  end

  context 'with keep_params option' do
    it 'recognizes option' do
      get :test_keep_params, params: { test: 'VALUE' }
      expect(assigns(:url_hash)).to eq('/samples')
    end
  end

  context 'with redirect_to' do
    it 'recognizes redirect_to' do
      get :test_redirect_to, params: { test: 'VALUE' }
      expect(response).to redirect_to('/samples?test=VALUE')
    end
  end
end
