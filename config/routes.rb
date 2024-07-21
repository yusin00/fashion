Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  resources :posts, only: [:new,:index, :show,:create,:edit,:update,:destroy]
  resources :users, only: [:show,:edit,:update,:destroy]
  resources :favorites, only: [:index,:create,:update,]
  get "/home/about" => "homes#about", as: "about"
  get 'mypage' => 'users#mypage'
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
