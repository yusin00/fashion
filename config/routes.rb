Rails.application.routes.draw do
  get 'tags/show'
  devise_for :users
  root to: 'homes#top'
  resources :posts, only: [:new,:index, :show,:create,:edit,:update,:destroy]
    resources :comments, only: [:index, :destroy,:create]
  resources :users, only: [:show,:edit,:update,:destroy]
  resources :tags, only: [:show]


  get "/home/about" => "homes#about", as: "about"
  get 'mypage' => 'users#mypage'

  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
    
  }

  namespace :admin do
    root 'dashboards#index'
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:show, :destroy]
    resources :post_comments, only: [:index, :destroy,:create]
  end


  resources :post_images, only: [:new, :create, :index, :show, :destroy] do
    resources :post_comments, only: [:create, :destroy]
    resources :favorites, only: [:index,:create,:update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
