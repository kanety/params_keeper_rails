describe ParamsKeeper::Controller do
  context 'without module' do
    it 'does not affect url_for' do
      controller = create_controller(ApplicationController, "/?key=value")
      expect(controller.url_for(controller: :application)).to eq('http://localhost/')
    end

    it 'does not affect redirect_to' do
      controller = create_controller(ApplicationController, "/?key=value")
      expect(controller.redirect_to(controller: :application)).to include('"http://localhost/"')
    end
  end

  context 'without config' do
    it 'does not affect url_for' do
      controller = create_controller(SamplesController, "/samples?key=value")
      expect(controller.url_for(controller: :samples)).to eq('http://localhost/samples')
    end

    it 'does not affect redirect_to' do
      controller = create_controller(ApplicationController, "/?key=value")
      expect(controller.redirect_to(controller: :samples)).to include('"http://localhost/samples"')
    end
  end
end
