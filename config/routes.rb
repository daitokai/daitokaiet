Daitokaiet::Application.routes.draw do
  use_doorkeeper do
    controllers :applications => 'doorkeeper/user_applications'
  end

  get 'social' => 'social#index'
  get 'social/:name' => 'social#show', as: 'show_social'
  get 'search' => 'social#search', as: 'search'
  post 'social/:id/follow' => 'social#follow', as: 'follow'
  post 'social/:id/unfollow' => 'social#unfollow', as: 'unfollow'
  resources :records, except: [:show]

  root 'home#index'

  devise_for :users, skip: [:password], :controllers => {
    :registrations => "users/registrations",
    :omniauth_callbacks => "users/omniauth_callbacks",
    :sessions => 'users/sessions'
  }

  namespace :api do
    namespace :v1 do
      resources :records, except: [:show]
      resource :users, only: [:show, :edit, :update]
      get 'social' => 'social#index'
      get 'social/:name' => 'social#show', as: 'show_social'
      get 'search' => 'social#search', as: 'search'
      post 'social/:id/follow' => 'social#follow', as: 'follow'
      post 'social/:id/unfollow' => 'social#unfollow', as: 'unfollow'
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
