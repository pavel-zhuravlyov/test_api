Rails.application.routes.draw do
  # before_filter :authenticate_user!

  post 'analyser/analyse'
  post 'analyser/correlation'

  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
