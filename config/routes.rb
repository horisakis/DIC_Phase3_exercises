Rails.application.routes.draw do
  get 'sessions/new'

  get '/', to: 'tweets#root'
  resources :tweets, except: :show do
    collection do
      post :confirm
    end
  end

  resources :sessions, only: %i[new create destroy]
  resources :users, only: %i[new create show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
