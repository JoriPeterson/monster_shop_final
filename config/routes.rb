Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get :root, to: 'welcome#index'

  resources :merchants do
    resources :items, only: [:index]
  end

  resources :items, only: [:index, :show] do
    resources :reviews, only: [:new, :create]
  end

  resources :reviews, only: [:edit, :update, :destroy]


  get '/cart', to: 'cart#show'
	get '/cart/edit', to: 'cart#edit'
	post '/cart', to: 'cart#new_address'
  post '/cart/:item_id', to: 'cart#add_item'
  delete '/cart', to: 'cart#empty'
  patch '/cart/:change/:item_id', to: 'cart#update_quantity'
  delete '/cart/:item_id', to: 'cart#remove_item'

  get '/registration', to: 'users#new', as: :registration
  get '/registration/address', to: 'users#new_address', as: :address_registration
  post '/registration/:user_id', to: 'users#create_address'
  patch '/user/:id', to: 'users#update'
  get '/profile', to: 'users#show'
  get '/profile/edit', to: 'users#edit'
  get '/profile/edit_password', to: 'users#edit_password'
  post '/orders', to: 'user/orders#create'
  get '/profile/orders', to: 'user/orders#index'
  get '/profile/orders/:id', to: 'user/orders#show'
  get '/profile/orders/:id/edit', to: 'user/orders#edit'
  post '/profile/orders/:id/edit', to: 'user/orders#new_address'
  patch '/profile/orders/:id', to: 'user/orders#update'
  delete '/profile/orders/:id', to: 'user/orders#cancel'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#login'
  get '/logout', to: 'sessions#logout'

	resources :users, only: [:create, :update]

	namespace :user do
		resources :addresses, only: [:index, :new, :create, :edit, :update, :destroy]
	end

  namespace :merchant do
    get '/', to: 'dashboard#index', as: :dashboard
    resources :orders, only: :show
    resources :items, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    put '/items/:id/change_status', to: 'items#change_status'
    get '/orders/:id/fulfill/:order_item_id', to: 'orders#fulfill'
  end

  namespace :admin do
    get '/', to: 'dashboard#index', as: :dashboard
    resources :merchants, only: [:show, :update]
    resources :users, only: [:index, :show]
    patch '/orders/:id/ship', to: 'orders#ship'
  end
end
