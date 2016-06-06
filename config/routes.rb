Rails.application.routes.draw do

  resources :topics do
    resources :posts, except: [:index]
  end

  resources :users, only: [:new, :create, :confirm]

  post 'users/confirm' => 'users#confirm'
  post 'users/new' => 'users#new'

  get 'about' => 'welcome#about'

  root 'welcome#index'

end
