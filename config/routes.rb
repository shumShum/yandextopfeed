Yandextopfeed::Application.routes.draw do

  resources :feeds, {only: :index}
  root to: 'feeds#index'

end
