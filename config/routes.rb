Rails.application.routes.draw do
  resources :sessions, only: %i[new create destroy]
  resources :users, only: %i[new create show edit update]
  resources :favorites, only: %i[index create destroy]

  get '/', to: 'tweets#root'
  resources :tweets, except: :show do
    collection do
      post :confirm
    end
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
