describe ParamsKeeper::Helper do
 it 'does not affect url_for outside of controller' do
   expect(SamplesController.helpers.url_for('test')).to eq('test')
  end
end
