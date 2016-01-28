Rails.application.routes.draw do
  scope :blog do
      devise_for :users, :controllers => { 
        omniauth_callbacks: "users/omniauth_callbacks",
        registrations: 'custom_devise/registrations', 
        sessions: 'custom_devise/sessions',
        confirmations: 'custom_devise/confirmations',
        passwords: 'custom_devise/passwords' 
       }, :skip => [:registrations,:sessions]
       devise_scope :user do
        post "/users/sign_in" => "custom_devise/sessions#create",as: 'user_session' 
        delete "/users/sign_out" => "custom_devise/sessions#destroy",as: 'destroy_user_session' 
        post "/users" => "custom_devise/registrations#create", as: 'user_registration' 
      end
      resources :users, :only => [:destroy]
      resources :categories, :only => [:create,:show,:destroy] do
        resources :articles
      end
      get '/'  =>  'blog#rootpage', as:"blog_root_page"
      match '/users/:id/finish_signup' => 'users#finish_signup', via: [:patch], :as => :finish_signup #get
      get 'testaction' => 'blog#testaction'
  end
  root 'static_pages#rootpage'

  match 'set_custom_locale', to:'http#set_custom_locale', via:'post';
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
