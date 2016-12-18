require 'sidekiq/web'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == 'admin' && password == 'qwerty12345'
end

Rails.application.routes.draw do
  mount Sidekiq::Web => '/async/tasks'
  mount ActionCable.server => '/app-cable'

  devise_for :users
  resources  :notes

  get '/search' => 'search#search', as: :search

  root to: "protozaur#index"
  get '/protozaur' => 'protozaur#index', as: :protozaur
  get '/ptz/flex' => 'protozaur#flex', as: :ptz_flex
  get '/ptz/framework' => 'protozaur#framework', as: :ptz_framework
  match '/ptz/inputs_buttons' => 'protozaur#inputs_buttons', as: :ptz_inputs_buttons, via: [:get, :post]
end

# For details on the DSL available within this file,
# see http://guides.rubyonrails.org/routing.html
