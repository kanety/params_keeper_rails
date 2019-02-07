Rails.application.routes.draw do
  resources :samples do
    collection do
      get :test
      3.times do |i|
        get "test_for#{i+1}"
      end
      3.times do |i|
        get "test_to#{i+1}"
      end
      get :test_keep_params
      get :test_redirect_to
    end
  end

  resources :others1
  resources :others2

  resources :normals
  resources :no_configs
end
