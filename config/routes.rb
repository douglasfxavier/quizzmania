Rails.application.routes.draw do
  resources :quizzs
  resources :types
  get 'home/index'
  root 'home#index'
  resources :answers, except: [:destroy, :edit]
  resources :questions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
