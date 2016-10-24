Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users

  namespace :admin do
    root "subjects#index"
    resources :subjects
    resources :users
    resources :levels
  end

  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"
  get "signup" => "users#new"
  resources :exams
  resources :suggest_questions
end
