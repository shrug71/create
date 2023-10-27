 Rails.application.routes.draw do
  
  resources :cafes, only: [:new, :create, :edit, :update]

   devise_for :users, path: 'api/v1/users', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'api/v1/users/sessions',
    registrations: 'api/v1/users/registrations'
  }

  delete 'api/v1/users/sign_out', to: 'api/v1/users/sessions#destroy', as: :destroy_api_v1_user_session

  namespace :api do
    namespace :v1 do
      namespace :users do
        resources :cafes, only: [:index, :show, :create, :update, :destroy]
        resources :menus
        resources :orders
      end
    end
  end
             
  #root to: "homes#index"
  resources :menus


  resources :orders do
    collection do
      get 'new/:cafe_id', to: 'orders#new', as: 'new_with_cafe'
    end

    member do
      put 'accept', to: 'orders#accept'
      put 'reject', to: 'orders#reject'
      put 'confirm', to: 'orders#confirm'
      put :cancel
    end
  end
  
  resources :order_menus


  resources :cafe_menus
  resources :cafes

  patch '/cafes/:id', to: 'cafes#update', as: 'update_cafe'

 post '/authenticate', to: 'authentication#authenticate'

  resources :users, only: [:new, :create]
 put 'orders/:id/confirm', to: 'orders#confirm', as: 'order_confirm'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

