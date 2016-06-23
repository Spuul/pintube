Rails.application.routes.draw do

  resources :videos
  resources :boards, only: [:create, :update, :destroy]

  root 'videos#index'

end
