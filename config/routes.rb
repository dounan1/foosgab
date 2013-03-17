Foosgab::Application.routes.draw do
  resources :players
  root to: "players#index"
end