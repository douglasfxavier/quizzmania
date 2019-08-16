Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  root 'home#index'

  authenticate :user do
  	resources :quizzs
  	resources :types
  	resources :questions
  	resources :tags
  	resources :answers
  end
  resources :answers, except: [:update, :destroy]
end
