Rails.application.routes.draw do
  resources :pages
  resources :users
  resources :tasks do
    member do
      post :add_child
    end
    put :assign_user, on: :member
  end
  resources :projects
  resources :papers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "projects#index"

  # get "/tasks", to: "tasks#index"
end
