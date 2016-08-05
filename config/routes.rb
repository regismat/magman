Rails.application.routes.draw do
  
 # resources :bookings
  get '/bookings/index'
  post '/bookings/clear'
  get '/bookings/new'
  get '/bookings/delete'
  post '/bookings/create'
  get '/bookings/alert'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'signup', to: 'users#new', as: 'signup'
  get 'sessions/new'
  resources :sessions
  get '/sessions/new'
  #resources :users
  get '/users/new'
  get '/users/list'
  get '/users/edit'
  get '/users/access_edit'
  post '/users/create'
  patch '/users/update'
  patch '/users/access_update'
  get '/users/notification'
  get '/users/grant'
  get '/bookings/list'
  
  namespace :admin do
  get 'role/list'
  #get 'role/show'
  end

  namespace :admin do
  get 'role/edit'
  end

  namespace :admin do
  patch 'role/update'
  end

  namespace :admin do
  get 'role/new'
  end

  namespace :admin do
  post 'role/create'
  end

  namespace :admin do
  get 'role/destroy'
  end

  get 'catalog/show'

  get '/catalog/index'

  get 'catalog/search'

  namespace :operation do
  get 'order/index'
  end

  namespace :operation do
  get 'order/new'
  end

  namespace :operation do
  post 'order/create'
  end

  namespace :operation do
  get 'order/show'
  end

  namespace :operation do
  get 'order/edit'
  end

  namespace :operation do
  patch 'order/update'
  end

  namespace :operation do
  get 'order/delete'
  end

  namespace :operation do
  get 'delivery/index'
  end

  namespace :operation do
  get 'delivery/new'
  end

  namespace :operation do
  post 'delivery/create'
  end

  namespace :operation do
  get 'delivery/show'
  end

  namespace :operation do
  get 'delivery/edit'
  end

  namespace :operation do
  patch 'delivery/update'
  end

  namespace :operation do
  get 'delivery/delete'
  end

  namespace :admin do
  get 'item/index'
  end

  namespace :admin do
  get 'item/new'
 
  end
  
  namespace :admin do 
  get 'item/alert'
  end
  
  namespace :admin do
  post 'item/create'
  end

  namespace :admin do
  get 'item/show'
  end

  namespace :admin do
  get 'item/edit'
  end

  namespace :admin do
  patch 'item/update'
  end

  namespace :admin do
  get 'item/delete'
  end

  namespace :admin do
  get 'provider/index'
  end

  namespace :admin do
  get 'provider/new'
  end

  namespace :admin do
  post 'provider/create'
  end

  namespace :admin do
  get 'provider/show'
  end

  namespace :admin do
  get 'provider/edit'
  end

  namespace :admin do
  patch 'provider/update'
  end

  namespace :admin do
  get 'provider/delete'
  end

  namespace :admin do
  get 'department/index'
  end

  namespace :admin do
  get 'department/show'
  end

  namespace :admin do
  get 'department/new'
  end

  namespace :admin do
  post 'department/create'
  end

  namespace :admin do
  get 'department/edit'
  end

  namespace :admin do
  patch 'department/update'
  end

  namespace :admin do
  get 'department/delete'
  end

  

  namespace :admin do
  get 'customer/index'
  end
  
  namespace :admin do
  get 'customer/show'
  end
  
  namespace :admin do
  get 'customer/new'
  end

  namespace :admin do
  post 'customer/create'
  end

  namespace :admin do
  get 'customer/edit'
  end

  namespace :admin do
  patch 'customer/update'
  end

  namespace :admin do
  get 'customer/delete'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root login_path

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
