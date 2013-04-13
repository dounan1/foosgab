Foosgab::Application.routes.draw do
  resources :players
  resources :games

  root to: "games#index"
end