Rails.application.routes.draw do
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # For updating points per dollar spent
  post 'update_points_per_dollar', :to => 'home#update_points_per_dollar'
end
