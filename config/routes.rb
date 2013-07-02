Yandextopfeed::Application.routes.draw do

  resources :feeds, {only: [:index, :update]} do 
  	collection {
  		get :out_by_options
  		get :put_feeds
  	}
  end
  get '/out_by_options' => 'feeds#out_by_options'
  root to: 'feeds#index'

end
