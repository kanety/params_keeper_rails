describe NoConfigsController, type: :request do
  it 'does not affect controllers with no config' do
    get no_configs_path, params: { test: 'VALUE' }
    expect(response.body).to include('@url = http://www.example.com/no_configs')
    expect(response.body).to include('link = <a href="/no_configs"></a>')
  end
end
