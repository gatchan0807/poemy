Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks'}
  get 'common/landing'

  root to: 'common#landing'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
