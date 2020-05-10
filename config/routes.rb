Rails.application.routes.draw do

  devise_for :users
  root to: "events#index"

  resources :events, only: [:show] do
    member do
      post :attend
      delete :unattend
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
