Foosgab::Application.routes.draw do
  resources :players
  resources :games

  get '/stats', to: 'stats#index'
  root to: 'games#index'
end