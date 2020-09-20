describe ParamsKeeper::Resolver do
  def resolver(controller, url_options)
    ParamsKeeper::Resolver.new(controller, url_options).call
  end

  context 'keeps params for url' do
    it 'unspecified' do
      controller = create_controller(SamplesController, "/samples?key=value", [:key])
      expect(resolver(controller, {})).to eq({ key: 'value' })
      expect(resolver(controller, "/samples")).to eq({})
      expect(resolver(controller, Sample.new(1))).to eq({})
    end

    it 'with hash' do
      controller = create_controller(SamplesController, "/samples?key=value", [:key, for: :hash])
      expect(resolver(controller, {})).to eq({ key: 'value' })
      expect(resolver(controller, "/samples")).to eq({})
      expect(resolver(controller, Sample.new(1))).to eq({})
    end

    it 'with string' do
      controller = create_controller(SamplesController, "/samples?key=value", [:key, for: :string])
      expect(resolver(controller, {})).to eq({})
      expect(resolver(controller, "/samples")).to eq({ key: 'value' })
      expect(resolver(controller, Sample.new(1))).to eq({})
    end

    it 'with model' do
      controller = create_controller(SamplesController, "/samples?key=value", [:key, for: :model])
      expect(resolver(controller, {})).to eq({})
      expect(resolver(controller, "/samples")).to eq({})
      expect(resolver(controller, Sample.new(1))).to eq({ key: 'value' })
    end
  end

  context 'keeps params with destination controller' do
    it 'unspecified' do
      controller = create_controller(SamplesController, "/samples?key=value", [:key])
      expect(resolver(controller, {})).to eq({ key: 'value' })
      expect(resolver(controller, { controller: :samples })).to eq({ key: 'value' })
      expect(resolver(controller, { controller: :others1 })).to eq({})
      expect(resolver(controller, { controller: :others2 })).to eq({})
    end

    it 'with symbol name' do
      controller = create_controller(SamplesController, "/samples?key=value", [:key, to: :others1])
      expect(resolver(controller, {})).to eq({})
      expect(resolver(controller, { controller: :samples })).to eq({})
      expect(resolver(controller, { controller: :others1 })).to eq({ key: 'value' })
      expect(resolver(controller, { controller: :others2 })).to eq({})
    end

    it 'with string name' do
      controller = create_controller(SamplesController, "/samples?key=value", [:key, to: 'others1'])
      expect(resolver(controller, {})).to eq({})
      expect(resolver(controller, { controller: :samples })).to eq({})
      expect(resolver(controller, { controller: :others1 })).to eq({ key: 'value' })
      expect(resolver(controller, { controller: :others2 })).to eq({})
    end
  end

  it 'skips keeping params' do
    controller = create_controller(SamplesController, "/samples?key=value", [:key])
    expect(resolver(controller, { keep_params: false })).to eq({})
  end
end
