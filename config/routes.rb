Foosgab::Application.routes.draw do
  resources :players
  resources :games

  get '/stats', to: 'stats#standings'
  root to: 'games#index'
end