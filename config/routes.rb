JkliuProj2::Application.routes.draw do
  match '/register' => 'users#new', :as => :register
  
  resources :users
  resources :sessions
  
  match '/login' => 'sessions#new', :as => :login
  match '/logout' => 'sessions#destroy', :as => :logout

  resources :products do
    member do
      get 'add_to_cart'
    end
  end

  match '/items/edit' => 'items#edit', :as => :edit_item, :via => :post
  match '/items/:id/remove' => 'items#remove', :as => :remove_item, :via => :get

  match '/carts/current' => 'carts#view_current', :as => :current_cart, :via => :get
  match '/carts/saved' => 'carts#view_saved', :as => :saved_carts, :via => :get
  
  match '/carts/:id/checkout' => 'carts#checkout', :as => :checkout
  match '/carts/:id/review' => 'carts#review', :as => :review_cart
  match '/carts/:id/save' => 'carts#save', :as => :save_cart
  match '/carts/:id/activate' => 'carts#activate', :as => :activate_cart
  
  match '/orders' => 'orders#create', :as => :place_order

  match '/admin' => 'orders#show'
  match '/admin/orders' => 'orders#show', :as => :admin_orders
  match '/admin/products' => 'products#admin_view', :as => :admin_products

  root :to => 'products#index'
end
