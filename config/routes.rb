Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: 'users' }

  # commons
  get '/users', to: 'common#landing'
  get '/landing', to: 'common#landing', as: 'landing'
  get '/about', to: 'common#about', as: 'about'
  get '/support', to: 'common#support', as: 'support'
  post '/support', to: 'common#post_support', as: 'post_support'
  get '/policies', to: 'common#policies', as: 'policies'

  # poems
  get '/popular', to: 'poems#popular_page', as: 'popular_poems_page'
  get '/poems/popular', to: 'poems#popular', as: 'popular_poems' # api
  get '/poems/:poem_id', to: 'poems#show_by_non_signed_in', as: 'poem_detail'

  get '/poems', to: 'poems#index', as: 'poems' # api
  get '/:user_id/poems', to: 'poems#index_of', as: 'poems_with_user' # api
  post '/:user_id/poems', to: 'poems#create', as: 'post_poem' # api
  get '/:user_id/poems/:poem_id', to: 'poems#show', as: 'poem_detail_with_user'
  delete '/:user_id/poems/:poem_id', to: 'poems#delete', as: 'delete_poem' # api
  post '/:user_id/poems/:poem_id/reaction', to: 'poems#add_reaction', as: 'add_reaction' # api

  # users
  get '/:user_id', to: 'users#show', as: 'user_detail'
  get '/:user_id/following', to: 'users#following', as: 'following'
  get '/:user_id/follower', to: 'users#follower', as: 'follower'
  post '/:user_id/follow', to: 'users#follow', as: 'follow' # api
  delete '/:user_id/follow', to: 'users#unfollow', as: 'unfollow' # api

  root to: 'common#landing'
end
