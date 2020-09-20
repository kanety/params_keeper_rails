describe ParamsKeeper::Controller do
  context 'redirect_to keeps params' do
    it 'for hash with hash arg' do
      controller = create_controller(SamplesController, "/samples?key=value", [:key, for: :hash])
      controller.redirect_to(controller: :samples)
      expect(controller.response.body).to include('"http://localhost/samples?key=value"')
    end

    it 'for hash with string arg' do
      controller = create_controller(SamplesController, "/samples?key=value", [:key, for: :hash])
      controller.redirect_to('/samples')
      expect(controller.response.body).to include('"http://localhost/samples"')
    end

    it 'for hash with model arg' do
      controller = create_controller(SamplesController, "/samples?key=value", [:key, for: :hash])
      controller.redirect_to(Sample.new(1))
      expect(controller.response.body).to include('"http://localhost/samples"')
    end

    it 'for string with hash arg' do
      controller = create_controller(SamplesController, "/samples?key=value", [:key, for: :string])
      controller.redirect_to(controller: :samples)
      expect(controller.response.body).to include('"http://localhost/samples"')
    end

    it 'for string with string arg' do
      controller = create_controller(SamplesController, "/samples?key=value", [:key, for: :string])
      controller.redirect_to('/samples')
      expect(controller.response.body).to include('"http://localhost/samples?key=value"')
    end

    it 'for string with model arg' do
      controller = create_controller(SamplesController, "/samples?key=value", [:key, for: :string])
      controller.redirect_to(Sample.new(1))
      expect(controller.response.body).to include('"http://localhost/samples"')
    end

    it 'for model with hash arg' do
      controller = create_controller(SamplesController, "/samples?key=value", [:key, for: :model])
      controller.redirect_to(controller: :samples)
      expect(controller.response.body).to include('"http://localhost/samples"')
    end

    it 'for model with string arg' do
      controller = create_controller(SamplesController, "/samples?key=value", [:key, for: :model])
      controller.redirect_to('/samples')
      expect(controller.response.body).to include('"http://localhost/samples"')
    end

    it 'for model with model arg' do
      controller = create_controller(SamplesController, "/samples?key=value", [:key, for: :model])
      controller.redirect_to(Sample.new(1))
      expect(controller.response.body).to include('"http://localhost/samples?key=value"')
    end
  end
end
