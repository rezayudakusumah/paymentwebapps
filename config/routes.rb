Rails.application.routes.draw do

  get "pages", to: "pages#index"
  get "access_payment", to: "pages#new"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "admin/dashboard#index"

  scope module: :public do
    # Pages
    resources :owes, path: "owe", only: :index
  end

end
