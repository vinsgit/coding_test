Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :contacts, only: [:index, :create, :new, :search] do
    collection do
      get :search
    end
  end

  resources :otps, only: [] do
    collection do
      post :request_otp
    end
  end
end
