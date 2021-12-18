describe SamplesController, type: :request do
  def keep_params(*options)
    SamplesController.clear_keep_params!
    SamplesController.keep_params *options
  end

  context 'url_for keeps params' do
    it 'for hash' do
      keep_params(:key, for: :hash)
      get samples_path, params: { key: 'value' }
      expect(response.body).to include('@url_for_hash: http://www.example.com/samples?key=value')
      expect(response.body).to include('link_to_hash: <a href="/samples?key=value">')
      expect(response.body).to include('@url_for_string: http://www.example.com/samples')
      expect(response.body).to include('link_to_string: <a href="/samples">')
      expect(response.body).to include('@url_for_model: http://www.example.com/samples')
      expect(response.body).to include('link_to_model: <a href="/samples">')
    end

    it 'for string' do
      keep_params(:key, for: :string)
      get samples_path, params: { key: 'value' }
      expect(response.body).to include('@url_for_hash: http://www.example.com/samples')
      expect(response.body).to include('link_to_hash: <a href="/samples">')
      expect(response.body).to include('@url_for_string: http://www.example.com/samples?key=value')
      expect(response.body).to include('link_to_string: <a href="/samples?key=value">')
      expect(response.body).to include('@url_for_model: http://www.example.com/samples')
      expect(response.body).to include('link_to_model: <a href="/samples">')
    end

    it 'for model' do
      keep_params(:key, for: :model)
      get samples_path, params: { key: 'value' }
      expect(response.body).to include('@url_for_hash: http://www.example.com/samples')
      expect(response.body).to include('link_to_hash: <a href="/samples">')
      expect(response.body).to include('@url_for_string: http://www.example.com/samples')
      expect(response.body).to include('link_to_string: <a href="/samples">')
      expect(response.body).to include('@url_for_model: http://www.example.com/samples?key=value')
      expect(response.body).to include('link_to_model: <a href="/samples?key=value">')
    end
  end

  if Rails.gem_version >= Gem::Version.new(5.1)
    context 'form keeps params' do
      it 'for hash' do
        keep_params(:key, for: :hash)
        get samples_path, params: { key: 'value' }
        expect(response.body).to include('<input type="hidden" name="key" value="value"')
      end

      it 'for string' do
        keep_params(:key, for: :string)
        get samples_path, params: { key: 'value' }
        expect(response.body).to include('<input type="hidden" name="key" value="value"')
      end

      it 'for model' do
        keep_params(:key, for: :model)
        get samples_path, params: { key: 'value' }
        expect(response.body).to include('<input type="hidden" name="key" value="value"')
      end
    end
  end
end
