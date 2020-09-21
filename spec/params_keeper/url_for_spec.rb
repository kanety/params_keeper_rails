describe ParamsKeeper::UrlFor do
  def url_for(controller, url_options)
    ParamsKeeper::UrlFor.new(controller, controller, url_options).call
  end

  it 'builds url' do
    controller = create_controller(SamplesController, "/samples?key=value", [:key])
    expect(url_for(controller, { controller: :samples, only_path: true })).to eq('/samples?key=value')
    expect(url_for(controller, { controller: :others1, only_path: true })).to eq(nil)
    expect(url_for(controller, { controller: :others2, only_path: true })).to eq(nil)
  end
end
