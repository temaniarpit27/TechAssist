Rails.application.routes.draw do

  

  resources :tag_users
  resources :asked_to_answers
  resources :notifications
  resources :users do 
    get 'settings' => 'users#settings'
  end
  resources :repositories
  get 'repo/get_all' => 'repositories#get_all_repos'

  
  resources :questions do
    resources :votes
    resources :answers
    resources :comments
    resources :answers do
      resources :votes
      resources :comments
    end
  end
  
  get '/users/:id/home_page_details' => 'users#get_user_home_details'
  get '/users/:id/repo_page_details' => 'users#get_repo_home_details'

  get 'experts' => 'repositories#get_experts'
  get '/users/:id/show_question' => 'questions#show_question'
  get '/users/:id/post_question' => 'questions#post_question'
  post '/users/:id/update_details' => "users#update_details"




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
