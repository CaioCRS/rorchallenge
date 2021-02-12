Rails.application.routes.draw do
  
  namespace 'api' do
    resources :cnab
    resources :tokens, only: [:create]
  end
end
