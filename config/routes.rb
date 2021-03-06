Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  root 'static_pages#index'

  resources :sessions, only: %i[new create destroy]

  resources :users, except: :index do
    resources :pictures do
      collection do
        post :confirm
      end
    end
    resources :favorites
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
