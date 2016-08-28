Rails.application.routes.draw do
  post 'analyser/analyse'
  post 'analyser/correlation'

  mount_devise_token_auth_for 'User', at: 'auth'
end
