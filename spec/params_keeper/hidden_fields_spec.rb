describe ParamsKeeper::HiddenFields do
  def hidden_fields(controller, url_options)
    ParamsKeeper::HiddenFields.new(controller, url_options).call
  end

  it 'builds hidden fields' do
    controller = create_controller(SamplesController, "/samples?key=value", [:key])
    expect(hidden_fields(controller, {})).to include('<input type="hidden" name="key" value="value" />')
    expect(hidden_fields(controller, { controller: :samples })).to include('<input type="hidden" name="key" value="value" />')
    expect(hidden_fields(controller, { controller: :others1 })).to eq(nil)
    expect(hidden_fields(controller, { controller: :others2 })).to eq(nil)
  end
end
