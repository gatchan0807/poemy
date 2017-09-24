Rails.application.routes.draw do
  get 'users/index'

  get 'users/show'

  get 'common/landing'

  root :to => 'common#landing'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
