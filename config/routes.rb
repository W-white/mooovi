TechReviewSite::Application.routes.draw do
  
  
  
  devise_for :users
  resources :users, only: :show
  resources :products, only: [:show, :new, :create, :edit, :update, :destroy] do
    resources :reviews, only: [:new, :create, :edit, :update, :destroy] 
    collection do
      get 'search'
    end
  end
  root 'products#index'
end
