describe NormalsController, type: :request do
  it 'does not affect normal controllers' do
    get normals_path, params: { test: 'VALUE' }
    expect(response.body).to include('@url = http://www.example.com/normals')
    expect(response.body).to include('link = <a href="/normals"></a>')
  end
end
