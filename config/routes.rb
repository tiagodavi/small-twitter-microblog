Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'signup#index'

   post 'login',to: 'login#enter', as: :enter
   get  'exit', to: 'login#exit',  as: :exit

   get  'signup', to: 'signup#index'
   post 'signup', to: 'signup#create'

   get  'profile', to: 'profile#index'
   get  'profile/:login', to: 'profile#show', as: :show_profile
   get  'profile/:login/follow', to: 'profile#follow', as: :follow_profile
   get  'profile/:login/unfollow', to: 'profile#unfollow', as: :unfollow_profile
   get  'users',  to: 'profile#users'
   get  'connect',  to: 'notifications#connect'
   post 'tweets', to: 'profile#create_tweet', as: :create_tweet
  

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
