Foosgab::Application.routes.draw do
  resources :players
  resources :games
  get '/stats', to: 'stats#index'

  # auth stuff
  get 'auth/:provider/callback', to: 'auth#google'
  get 'auth/failure', to: redirect('/')
  get 'auth/claim', to: 'auth#claim', as: 'claim_player'
  post 'auth/finish', to: 'auth#finish', as: 'finish_claim_player'

  # session stuff
  # get 'signin', redirect('/auth/google_oauth2'), as: 'signin'
  get 'signout', to: 'sessions#destroy', as: 'signout'

  root to: 'games#index'
end