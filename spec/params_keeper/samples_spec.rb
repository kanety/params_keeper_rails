describe SamplesController, type: :request do
  context 'basic use' do
    it 'keeps params through url_for' do
      get test_samples_path, params: { test: 'VALUE' }
      expect(response.body).to include('@url_hash = http://www.example.com/samples?test=VALUE')
      expect(response.body).to include('@url_string = http://www.example.com/samples')
      expect(response.body).to include('@url_model = http://www.example.com/samples')
      expect(response.body).to include('link_to_hash = <a href="/samples?test=VALUE"></a>')
      expect(response.body).to include('link_to_string = <a href="/samples"></a>')
      expect(response.body).to include('link_to_model = <a href="/samples"></a>')
    end
  end

  context ':for config' do
    it 'keeps params for hash' do
      get test_for1_samples_path, params: { test: 'VALUE' }
      expect(response.body).to include('@url_hash = http://www.example.com/samples?test=VALUE')
      expect(response.body).to include('@url_string = http://www.example.com/samples')
      expect(response.body).to include('@url_model = http://www.example.com/samples')
    end

    it 'keeps params for string' do
      get test_for2_samples_path, params: { test: 'VALUE' }
      expect(response.body).to include('@url_hash = http://www.example.com/samples')
      expect(response.body).to include('@url_string = http://www.example.com/samples?test=VALUE')
      expect(response.body).to include('@url_model = http://www.example.com/samples')
    end

    it 'keeps params for model' do
      get test_for3_samples_path, params: { test: 'VALUE' }
      expect(response.body).to include('@url_hash = http://www.example.com/samples')
      expect(response.body).to include('@url_string = http://www.example.com/samples')
      expect(response.body).to include('@url_model = http://www.example.com/samples?test=VALUE')
    end
  end

  if Rails.gem_version >= Gem::Version.new(5.1)
    context 'form' do
      it 'builds hidden_fields for hash' do
        get test_for1_samples_path, params: { test: 'VALUE' }
        expect(response.body).to include('<input type="hidden" name="test" value="VALUE" />')
      end

      it 'builds hidden_fields for string' do
        get test_for2_samples_path, params: { test: 'VALUE' }
        expect(response.body).to include('<input type="hidden" name="test" value="VALUE" />')
      end

      it 'builds hidden_fields for model' do
        get test_for3_samples_path, params: { test: 'VALUE' }
        expect(response.body).to include('<input type="hidden" name="test" value="VALUE" />')
      end
    end
  end

  context ':to config' do
    it 'keeps params in same controller without :to config' do
      get test_to1_samples_path, params: { test: 'VALUE' }
      expect(response.body).to include('@url_samples1 = /samples?test=VALUE')
      expect(response.body).to include('@url_samples2 = /samples?test=VALUE')
      expect(response.body).to include('@url_others1 = /others1')
      expect(response.body).to include('@url_others2 = /others2')
    end

    it 'keeps params in specific controller with string :to config' do
      get test_to2_samples_path, params: { test: 'VALUE' }
      expect(response.body).to include('@url_samples1 = /samples')
      expect(response.body).to include('@url_samples2 = /samples')
      expect(response.body).to include('@url_others1 = /others1?test=VALUE')
      expect(response.body).to include('@url_others2 = /others2')
    end

    it 'keeps params in specific controller with symbol :to config' do
      get test_to3_samples_path, params: { test: 'VALUE' }
      expect(response.body).to include('@url_samples1 = /samples')
      expect(response.body).to include('@url_samples2 = /samples')
      expect(response.body).to include('@url_others1 = /others1?test=VALUE')
      expect(response.body).to include('@url_others2 = /others2')
    end
  end

  context 'with keep_params option' do
    it 'recognizes option' do
      get test_keep_params_samples_path, params: { test: 'VALUE' }
      expect(response.body).to include('@url_hash = /samples')
    end
  end

  context 'with redirect_to' do
    it 'recognizes redirect_to' do
      get test_redirect_to_samples_path, params: { test: 'VALUE' }
      expect(response).to redirect_to('http://www.example.com/samples?test=VALUE')
    end
  end
end
