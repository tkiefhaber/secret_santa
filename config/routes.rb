SecretSanta::Application.routes.draw do
  root 'groups#new'
  resources :groups

end
