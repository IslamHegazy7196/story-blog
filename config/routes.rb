Rails.application.routes.draw do
  resources :reviews
  resources :posts do
    collection do
      get 'top', to: 'posts#top'
    end
  end
  resources :users

  # Set root path to the 'top' action of the 'posts' controller
  root 'posts#top'
end
