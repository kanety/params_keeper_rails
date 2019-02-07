class SamplesController < ActionController::Base
  include ParamsKeeper::Controller

  def render_index
    @url_hash = url_for(action: :index)
    @url_string = url_for("http://www.example.com/samples")
    @url_model = url_for(Sample.new(1))
    render :index
  end

  def test
    self.class.keep_params :test
    render_index
  end

  def test_for1
    self.class.keep_params :test, for: :hash
    render_index
  end

  def test_for2
    self.class.keep_params :test, for: :string
    render_index
  end

  def test_for3
    self.class.keep_params :test, for: :model
    render_index
  end

  def render_to
    @url_samples1 = url_for(action: :index, only_path: true)
    @url_samples2 = url_for(controller: :samples, action: :index, only_path: true)
    @url_others1 = url_for(controller: :others1, action: :index, only_path: true)
    @url_others2 = url_for(controller: :others2, action: :index, only_path: true)
    render inline: <<-ERB
      @url_samples1 = <%= @url_samples1 %>
      @url_samples2 = <%= @url_samples2 %>
      @url_others1 = <%= @url_others1 %>
      @url_others2 = <%= @url_others2 %>
    ERB
  end

  def test_to1
    self.class.keep_params :test
    render_to
  end

  def test_to2
    self.class.keep_params :test, to: %w(others1)
    render_to
  end

  def test_to3
    self.class.keep_params :test, to: [:others1]
    render_to
  end

  def test_keep_params
    self.class.keep_params :test
    @url_hash = url_for(action: :index, keep_params: false, only_path: true)
    render inline: <<-ERB
      @url_hash = <%= @url_hash %>
    ERB
  end

  def test_redirect_to
    self.class.keep_params :test
    redirect_to action: :index
  end
end
